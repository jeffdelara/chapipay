class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.text :customer_details
      t.text :delivery_details
      t.float :total

      t.timestamps
    end
  end
end
