module Products
  class ProductService
    def self.find(id)
      Products::ProductRepository.find(id)
    end

    def self.all 
      Products::ProductRepository.all
    end
    
    def self.all_in_stock 
      Products::ProductRepository.all_in_stock
    end
  end
end
