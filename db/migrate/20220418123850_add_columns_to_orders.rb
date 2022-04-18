class AddColumnsToOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :user_id, :integer
    add_column :orders, :customer_details, :text
    add_column :orders, :delivery_details, :text
    add_column :orders, :total, :decimal
    add_column :orders, :status, :string
  end
end
