class Reservation < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :room

  before_validation :get_total_price
  before_validation :generate_code

  before_validation :check_capacity
  before_validation :check_availability

  enum :status, { pending: 0, confirmed: 1, active: 2, canceled: 3, finished: 4}

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
