module Store 
  class StoreService 
    
    def initialize 
    end

    def self.get_all_products
      Products::ProductRepository.get_store_products
    end

    def self.get(id)
      Products::ProductRepository.find(id)
    end

  end
end
