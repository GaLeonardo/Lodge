class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  enum role: {visitor: 0, host: 1} 

  has_one :lodge
  has_many :reservations

  validates :first_name, :last_name, :personal_id, :role, presence: true
end
