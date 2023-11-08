class Room < ApplicationRecord
  belongs_to :lodge
  has_one :service
  has_many :seasonal_prices
end
