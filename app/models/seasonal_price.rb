class SeasonalPrice < ApplicationRecord
  belongs_to :room
  validates :name, :start_date, :end_date, :price, presence: true
  validate :has_seasonal_overlap?

  def has_seasonal_overlap?
    actual_seasons = (self.start_date..self.end_date)
    self.room.seasonal_prices.any? do |season|
      unless self == season
        season_range = (season.start_date..season.end_date)
        if actual_seasons.overlaps? season_range
          errors.add(:seasonal_price, 'Preço de temporada não pode ter conflito com outros períodos.')
        end
      end
    end
  end
  
end
