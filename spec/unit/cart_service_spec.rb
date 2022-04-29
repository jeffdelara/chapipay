require 'rails_helper'

RSpec.describe Cart::CartService do 

  let (:customer) { Customer.last }
  let (:product) { Product.last }

  describe '.add' do 
    context 'adding items to cart' do 
      it 'should return false when no product found' do 
        response = Cart::CartService.add(customer, 999)
        expect(response).to eq(false)
      end


      it 'should add cart if product is found' do 
        Cart::CartService.remove_all(customer)
        cart = Cart::CartService.get(customer)

        # should be 0 
        previous_cart_count = cart.count

        Cart::CartService.add(customer, product)
        cart_new = Cart::CartService.get(customer)

        expect(cart_new.count).to eq(previous_cart_count + 1)
      end

      it 'should reduce cart size if item is removed' do 
        Cart::CartService.add(customer, product.id)
        cart = Cart::CartService.get(customer)

        Cart::CartService.remove(customer, cart.first.id)
        cart_now = Cart::CartService.get(customer)

        expect(cart_now.count).to eq(0)
      end

    end
  end

  describe '.get' do 
    context 'collections of cart items' do 
      it 'returns a collection' do 
        collection = Cart::CartService.get(customer).kind_of? (ActiveRecord::Associations::CollectionProxy)

        expect(collection).to be_truthy
      end
    end
  end

  describe '.get_total' do 
  end

  describe '.remove' do 
  end

  describe '.remove_all' do 
  end

  describe '.update' do 
  end
end
