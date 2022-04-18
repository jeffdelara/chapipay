class ChangeTotalInOrders < ActiveRecord::Migration[6.1]
  def change
    change_column :orders, :total, :decimal
  end
end
