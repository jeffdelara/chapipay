class RemoveColumnsFromOrderLines < ActiveRecord::Migration[6.1]
  def change
    remove_column :order_lines, :user_id
    remove_column :order_lines, :order_id
  end
end
