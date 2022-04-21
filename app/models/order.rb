class Order < ApplicationRecord

  belongs_to :user
  has_many :order_lines


  validates :customer_details, presence: true
  validates :delivery_details, presence: true
  validates :status, presence: true
end
