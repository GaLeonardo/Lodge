class SeasonalPrice < ApplicationRecord
  belongs_to :room
  validates :name, :start_date, :end_date, :price, presence: true
  validate :has_seasonal_overlap?
  validate :end_date_greater_or_equal_to_start_date
  validate :start_date_past

  def has_seasonal_overlap?
    return false if self.room.nil?

    actual_seasons = (self.start_date..self.end_date)

    self.room.seasonal_prices.any? do |season|
      unless self == season
        season_range = (season.start_date..season.end_date)
        if actual_seasons.overlaps? season_range
          errors.add('Preço de temporada', 'não pode ter conflito com outros períodos.')
        end
      end
    end
  end

  private

  def end_date_greater_or_equal_to_start_date
    if start_date.present? && end_date.present? && end_date <= start_date
      errors.add(:end_date, :end_date_before_start_date)
    end
  end
  

  def start_date_past
    if start_date.present? && start_date.past?
      errors.add(:start_date, :start_date_past)
    end
  end
end
