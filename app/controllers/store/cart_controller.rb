class Store::CartController < ApplicationController
  def index 
  end

  def show 
    # show all cart items 
    @cart_items = Cart::CartService.get(current_user)
  end

  def new 
  end 

  def create 
    response = Cart::CartService.add(
      current_user, params[:product_id]
    )
    
    if response 
      redirect_to cart_index_path, notice: 'Item added to cart.'
    else  
      redirect_to root_path
    end
  end

  def edit 
  end

  def update 
    response = Cart::CartService.update(
      id: cart_params[:id],   
      quantity: cart_params[:quantity],
      customer: current_user
    )
    
    render Cart::CartUpdateSerializer.run(response)
  end

  def destroy
    Cart::CartService.remove(current_user, params[:id])
    redirect_to cart_index_path, notice: 'Item removed from cart.'
  end

  private 
  def cart_params 
    params.require(:cart_items).permit(:id, :quantity, :product_id)
  end
end
