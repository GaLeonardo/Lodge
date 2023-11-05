class CreateServices < ActiveRecord::Migration[7.1]
  def change
    create_table :services do |t|
      t.boolean :bathroom
      t.boolean :balcony
      t.boolean :air_conditioner
      t.boolean :tv
      t.boolean :closet
      t.boolean :vault
      t.boolean :accessibility
      t.references :lodge_room, null: false, foreign_key: true

      t.timestamps
    end
  end
end
