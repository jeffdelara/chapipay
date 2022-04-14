class AddCartItemsCountToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :cart_items_count, :integer
  end
end
