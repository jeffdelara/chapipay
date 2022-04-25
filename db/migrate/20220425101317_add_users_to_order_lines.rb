class AddUsersToOrderLines < ActiveRecord::Migration[6.1]
  def change
    add_reference :order_lines, :user, null: false, foreign_key: true
  end
end
