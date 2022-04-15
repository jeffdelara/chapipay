module Products
  class ProductService
    def self.find(id)
      Products::ProductRepository.find(id)
    end

    def self.all 
      Products::ProductRepository.all
    end
  end
end
