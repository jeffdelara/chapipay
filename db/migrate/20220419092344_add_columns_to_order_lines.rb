class AddColumnsToOrderLines < ActiveRecord::Migration[6.1]
  def change
    add_column :order_lines, :order_id, :bigint
    add_column :order_lines, :user_id, :bigint
    add_column :order_lines, :product_name, :text
    add_column :order_lines, :price, :decimal
    add_column :order_lines, :quantity, :integer
    add_column :order_lines, :subtotal, :decimal
    add_column :order_lines, :sku, :string
  end
end
