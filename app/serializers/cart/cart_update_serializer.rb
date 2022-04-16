module Cart 
  class CartUpdateSerializer 
    def self.run(response)
      if response 
        return :json => {
          :status => :ok, 
          :cart_item => response
        }, :include => :product
      else 
        retun :json => {:errors => 'Can not be saved.'}
      end
    end
  end
end
