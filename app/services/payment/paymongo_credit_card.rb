module Payment 
  class PaymongoCreditCard 
    
    def self.make_payment(card, amount, description)
      paymongo = Paymongo::V1::CardPayment.new
      
      begin 
        payment_method = paymongo.create_payment_method(card)
        payment_intent = paymongo.create_payment_intent(
          amount.to_i * 100, 
          description
        )
        
      rescue ApiExceptions::BadRequest
        raise StandardError
      end

      payment_intent_id = payment_intent['data']['id']
      client_key = payment_intent['data']['attributes']['client_key']
      payment_method_id = payment_method['data']['id']

      response = paymongo.attach(
        payment_intent_id, 
        payment_method_id, 
        client_key
      )
      
      # awaiting_next_action
      status = response['data']['attributes']['status']
      return_url = nil 

      if status == 'awaiting_next_action'
        return_url = response['data']['attributes']['next_action']['redirect']['url']
      end

      return { 
        :status => response['data']['attributes']['status'],
        :payment_intent_id => response['data']['id'],
        :return_url => return_url
      }
    end

  end
end
