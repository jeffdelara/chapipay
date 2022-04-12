class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :name
      t.decimal :price, precision: 10, scale: 2
      t.text :description
      t.references :category, null: false, foreign_key: true
      t.string :sku
      t.boolean :in_stock, default: false 

      t.timestamps
    end
  end
end
