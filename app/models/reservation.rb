class Reservation < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :room

  before_validation :get_total_price




  def get_total_price
    self.total_price = self.room.calculate_rent_price(self.start_date, self.end_date)
  end
end
