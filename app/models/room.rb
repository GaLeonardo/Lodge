class Room < ApplicationRecord
  belongs_to :lodge
  has_one :service
  has_many :seasonal_prices
  has_many :reservations

  validates :name, :description, :area, :max_capacity, :standard_price, presence: true
  validates :name, uniqueness: true

  def calculate_rent_price(start_date, end_date)
    seasonals = calculate_seasonal_days(start_date, end_date)
    regulars = calculate_regular_days(start_date, end_date, seasonals)
    seasonals[self.standard_price] = regulars
    calculate_period_price(seasonals)
  end

  def check_availability(start_date, end_date)
    reservations.where(status: [:confirmed, :active]).any? do |reservation|
      reservation_range = reservation.start_date..reservation.end_date
      reservation_range.overlaps?(start_date..end_date)
    end
  end

  private

  def calculate_regular_days(start_date, end_date, seasonals)
    (end_date - start_date).to_i - seasonals.values.sum
  end

  def calculate_seasonal_days(start_date, end_date)
    seasonals = Hash.new(0)
  
    self.seasonal_prices.each do |seasonal|
      season_range = (seasonal.start_date..seasonal.end_date)
      (start_date..end_date).each do |date|
        seasonals[seasonal.price] += 1 if season_range.cover?(date)
      end
    end
    seasonals
  end

  def calculate_period_price(seasonals)
    seasonals.sum { |price, days| price * days }
  end
end
