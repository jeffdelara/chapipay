class Store::CartController < ApplicationController
  def index 
  end

  def show 
    # show all cart items 
    @cart_items = current_user.cart_items
  end

  def new 
  end 

  def create 
    # add items into the cart
    @cart_item = current_user.cart_items.where(
        :product_id => params[:product_id]
      ).first_or_create
    
    @cart_item.quantity += 1
    
    if @cart_item.save 
      redirect_to cart_index_path, notice: 'Item added to cart.'
    else  
      redirect_to root_path
    end
  end

  def edit 
  end

  def update 
    # update cart 
    @cart_item = current_user.cart_items.find_by(:id => cart_params[:id])
    @cart_item.quantity = cart_params[:quantity]
    
    if @cart_item.save 
      render :json => {
        :status => :ok, 
        :cart_item => @cart_item
      }, :include => :product
    else 
      render :json => {:errors => 'Can not be saved.'}
    end
  end

  def destroy
    # delete a cart item
    @cart_item = current_user.cart_items.find(params[:id])
    @cart_item.destroy
    redirect_to cart_index_path, notice: 'Item removed from cart.'
  end

  private 
  def cart_params 
    params.require(:cart_items).permit(:id, :quantity, :product_id)
  end
end
