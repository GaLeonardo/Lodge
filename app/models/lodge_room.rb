class LodgeRoom < ApplicationRecord
  belongs_to :lodge_house
  has_one :service
end
