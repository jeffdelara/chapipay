class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :addresses, dependent: :destroy
  has_many :cart_items
  has_many :products, :through => :cart_items
  has_many :orders
  has_many :order_lines, :through => :orders

  def customer? 
    !self.admin?
  end

end
