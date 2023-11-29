class CreateReviews < ActiveRecord::Migration[7.1]
  def change
    create_table :reviews do |t|
      t.integer :rating
      t.string :commentary
      t.references :reservation, null: false, foreign_key: true

      t.timestamps
    end
  end
end
