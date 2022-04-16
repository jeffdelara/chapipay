module Products 
  class ProductRepository

    def self.find(id)
      Product.friendly.find(id)
    end

    def self.all 
      Product.includes(:category).all
    end

    def self.all_in_stock 
      Product.where(:in_stock => true)
    end

  end
end
