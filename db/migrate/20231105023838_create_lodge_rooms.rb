class CreateLodgeRooms < ActiveRecord::Migration[7.1]
  def change
    create_table :lodge_rooms do |t|
      t.string :name
      t.string :description
      t.integer :area
      t.integer :number_people
      t.integer :standard_price
      t.references :lodge_house, null: false, foreign_key: true

      t.timestamps
    end
  end
end
