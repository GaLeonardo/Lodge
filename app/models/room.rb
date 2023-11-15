class Room < ApplicationRecord
  belongs_to :lodge
  has_one :service
  has_many :seasonal_prices

  validates :name, :description, :area, :max_people, :standard_price, presence: true
  validates :name, uniqueness: true
end
