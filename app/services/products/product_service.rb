module Products
  class ProductService
    def self.find(id)
      Product.friendly.find(id)
    end
  end
end
