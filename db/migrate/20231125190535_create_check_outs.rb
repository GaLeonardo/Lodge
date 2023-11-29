class CreateCheckOuts < ActiveRecord::Migration[7.1]
  def change
    create_table :check_outs do |t|
      t.references :reservation, null: false, foreign_key: true
      t.string :payment_method
      t.integer :total_paid

      t.timestamps
    end
  end
end
