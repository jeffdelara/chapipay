class Product < ApplicationRecord
  
  belongs_to :category
  validates :name, :price, :category_id, presence: true 

end
