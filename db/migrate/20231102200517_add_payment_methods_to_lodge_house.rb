class AddPaymentMethodsToLodgeHouse < ActiveRecord::Migration[7.1]
  def change
    add_reference :lodge_houses, :payment_methods, null: false, foreign_key: true
  end
end
