class AddStateToAddresses < ActiveRecord::Migration[6.1]
  def change
    add_column :addresses, :state, :string
  end
end
