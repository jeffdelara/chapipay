module Customers
  class CustomerService

    def initialize(attr)
      @user = {
        first_name: attr[:first_name], 
        last_name: attr[:last_name],
        email: attr[:email],
        password: attr[:password]
      }
    end
  
    def create
      Customer.create(@user)
    end

    def self.all 
      Customer.where(:admin => false).order(:updated_at => :DESC)
    end

    def self.find(id)
      Customer.find_by(:id => id, :admin => false)
    end

    def self.cart_exists?(id)
      cart = CartItem.find_by(:user_id => id)
      if cart 
        return cart 
      else 
        return false 
      end
    end

    def self.get_addresses(id)
      Address.where(:user_id => id)
    end

  end
end
