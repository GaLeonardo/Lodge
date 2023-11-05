class AddStatusToLodgeHouse < ActiveRecord::Migration[7.1]
  def change
    add_column :lodge_houses, :status, :integer
  end
end
