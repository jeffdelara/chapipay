class CreateAddresses < ActiveRecord::Migration[6.1]
  def change
    create_table :addresses do |t|
      t.string :house_number
      t.string :street
      t.string :town
      t.string :city
      t.string :country
      t.string :zip_code
      t.string :mobile_number
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
