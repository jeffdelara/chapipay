class CartItem < ApplicationRecord
  belongs_to :product
  belongs_to :user, counter_cache: true
end
