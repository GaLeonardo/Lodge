class CreateServices < ActiveRecord::Migration[7.1]
  def change
    create_table :services do |t|
      t.boolean :has_bathroom
      t.boolean :has_balcony
      t.boolean :has_air_conditioner
      t.boolean :has_tv
      t.boolean :has_closet
      t.boolean :has_vault
      t.boolean :is_accessible
      t.references :room, null: false, foreign_key: true

      t.timestamps
    end
  end
end
