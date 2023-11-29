class Review < ApplicationRecord
  belongs_to :reservation

  has_one :host_reply

  validates :rating, :commentary, presence: true
end
