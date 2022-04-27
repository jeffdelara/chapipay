class OrderLine < ApplicationRecord

  belongs_to :user
  belongs_to :order

  validates :product_name,
            :price,
            :quantity,
            :subtotal,
            :sku,
            presence: true
end
