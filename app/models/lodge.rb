class Lodge < ApplicationRecord
  belongs_to :user

  validates :corporate_name, :brand_name, :registration_number, :full_address, :city, :state, :email, :zip_code, :contact_number, :description, :pets, :terms_of_service, :check_in, :check_out, :status, presence: true
  validates :registration_number, uniqueness: true

  has_many :rooms
  has_many :reservations, through: :rooms
  
  has_one :payment_method
  
  enum status: {ativo: 1, inativo: 0}
  enum pets: {sim: 1, nao: 0}

  def self.search search_term
    where(['lower(brand_name) LIKE ? OR lower(city) LIKE ? OR lower(full_address) LIKE ?', "%#{search_term}%", "%#{search_term}%", "%#{search_term}%"]).order(:brand_name)
  end
end
