class RemovePayingMethodsFromLodgeHouse < ActiveRecord::Migration[7.1]
  def change
    remove_column :lodge_houses, :paying_methods, :string
  end
end
