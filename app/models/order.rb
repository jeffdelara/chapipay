class Order < ApplicationRecord

  belongs_to :user
  has_many :order_lines, dependent: :destroy

  validates :customer_details, presence: true
  validates :delivery_details, presence: true
  validates :status, presence: true

  STATUSES = ['pending', 'processing', 'paid', 'completed']

end
