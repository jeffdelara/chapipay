module Payment
  class PaymongoGcash
    
    def self.make_source(amount)
      paymongo = Paymongo::V1::GcashPayment.new

      begin
        src = paymongo.create_source(amount.to_i * 100) 
      rescue ApiExceptions::BadRequest
        raise StandardError
      end

      src_id = src['data']['id']
      src_status = src['data']['attributes']['status']
      src_checkout_url = src['data']['attributes']['redirect']['checkout_url']
      
      return {
        :id => src_id,
        :status => src_status,
        :checkout_url => src_checkout_url
      }
    end

    def self.get_source(src_id)
      paymongo = Paymongo::V1::GcashPayment.new

      begin
        retrieve_src = paymongo.retrieve_source(src_id)
      rescue ApiExceptions::BadRequest
        raise StandardError
      end

      retrieve_src_amount = retrieve_src['data']['attributes']['amount']

      return { 
        :amount => retrieve_src_amount 
      }
    end

    def self.make_payment(amount, src_id)
      paymongo = Paymongo::V1::GcashPayment.new

      begin
        pay = paymongo.create_payment(amount, src_id)
      rescue ApiExceptions::BadRequest
        raise StandardError
      end

      pay_id = pay['data']['id']

      return {
        :id => pay_id
      }
    end
  end
end
