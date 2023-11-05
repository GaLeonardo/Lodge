class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  enum role: {Visitante: 0, Anfitrião: 1} 
  
          

  has_one :lodge_house

  validates :name, :role, presence: true
end
