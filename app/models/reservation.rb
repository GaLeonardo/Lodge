class Reservation < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :room

  has_one :check_in

  before_validation :get_total_price, on: :create
  before_validation :generate_code, on: :create

  before_validation :check_capacity, on: :create
  before_validation :check_availability, on: :create

  enum :status, { pending: 0, confirmed: 1, active: 2, canceled: 3, finished: 4}

  def cancel_unless_less_than_seven_days
    self.start_date >= 7.days.from_now.to_date
  end

  def check_in
    self.build_check_in.save
    self.active!
  end

  def cancel
    if self.start_date <= 2.days.ago.to_date
      self.canceled!
    end
  end

  private

  def get_total_price
    self.total_price = self.room.calculate_rent_price(self.start_date, self.end_date)
  end

  def generate_code
    letters = ('A'..'Z').to_a
    numbers = (0..9).to_a

    random_letters = Array.new(4) { letters.sample }.join
    random_numbers = Array.new(4) { numbers.sample }.join

    self.code = "#{random_letters}#{random_numbers}"
  end

  def check_capacity
    if number_guests > self.room.max_capacity
      errors.add(:number_guests, 'excede a capacidade do quarto.')
    end
  end

  def check_availability
    if self.room.check_availability(self.start_date, self.end_date)
      errors.add(:room, 'não disponível na data selecionada.')
    end
  end
end
