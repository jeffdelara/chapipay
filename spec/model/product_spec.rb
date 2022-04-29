require 'rails_helper'

RSpec.describe Product, type: :model do 
  describe 'validate' do 
    let (:product) { Product.new }
    let (:category) { Category.last }

    context 'name, price, category_id' do 
    
      it 'present' do 
        expect(product).not_to be_valid
      end

      it 'present' do 
        product.name = 'Test'
        expect(product).not_to be_valid
      end

      it 'present' do 
        product.price = 112
        expect(product).not_to be_valid
      end

      it 'present' do 
        product.category_id = 1
        expect(product).not_to be_valid
      end
    
    end

  end
end
