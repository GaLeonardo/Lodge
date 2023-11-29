class Review < ApplicationRecord
  belongs_to :reservation

  validates :rating, :commentary, presence: true
end
