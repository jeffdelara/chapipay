class Product < ApplicationRecord
  
  belongs_to :category
  validates :name, :price, :category_id, presence: true 
  
  has_many :cart_items, dependent: :destroy
  has_many :users, :through => :cart_items

  has_rich_text :description
  
  has_many_attached :images do |attachable|
    attachable.variant :thumb, resize_to_limit: [100, 100]
  end
  
  extend FriendlyId
  friendly_id :name, use: :slugged

end
