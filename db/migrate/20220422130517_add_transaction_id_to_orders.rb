class AddTransactionIdToOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :transaction_id, :string
  end
end
