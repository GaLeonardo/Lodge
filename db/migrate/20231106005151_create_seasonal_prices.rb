class CreateSeasonalPrices < ActiveRecord::Migration[7.1]
  def change
    create_table :seasonal_prices do |t|
      t.string :name
      t.date :start_date
      t.date :end_date
      t.integer :price
      t.references :room, null: false, foreign_key: true

      t.timestamps
    end
  end
end
