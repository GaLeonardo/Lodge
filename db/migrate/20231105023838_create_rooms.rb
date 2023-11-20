class CreateRooms < ActiveRecord::Migration[7.1]
  def change
    create_table :rooms do |t|
      t.string :name
      t.string :description
      t.integer :area
      t.integer :max_capacity
      t.integer :standard_price
      t.references :lodge, null: false, foreign_key: true

      t.timestamps
    end
  end
end
