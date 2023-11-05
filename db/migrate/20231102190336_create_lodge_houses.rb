class CreateLodgeHouses < ActiveRecord::Migration[7.1]
  def change
    create_table :lodge_houses do |t|
      t.string :corporate_name
      t.string :brand_name
      t.string :registration_number
      t.string :full_address
      t.string :city
      t.string :state
      t.string :email
      t.string :zip_code
      t.string :contact_number
      t.string :description
      t.integer :paying_methods
      t.integer :pets
      t.string :terms_of_service
      t.string :check_in
      t.string :check_out
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
