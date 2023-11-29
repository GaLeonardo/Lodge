class HostReply < ApplicationRecord
  belongs_to :review

  validates :reply, presence: true
end
