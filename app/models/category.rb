class Category < ApplicationRecord

  has_many :products
  has_one_attached :image
  validates :name, :image, :presence => true

end
