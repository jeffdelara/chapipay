module Store 
  class StoreService 
    
    def initialize 
    end

    def self.get_all_products
      Product.where(:in_stock => true)
    end

  end
end
