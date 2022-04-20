module Paymongo
  module V1
    class CardPayment
      include ApiExceptions
      BASE_URL = 'https://api.paymongo.com/v1'
      PAYMENT_INTENTS = 'payment_intents'
      PAYMENT_METHODS = 'payment_methods'
      RETURN_URL = Settings.PAYMONGO_RETURN_URL
      PUBLIC_KEY = Rails.application.credentials.paymongo[:public_key] 
      SECRET_KEY = Rails.application.credentials.paymongo[:secret_key]

      def prepare_http(url)
        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = true
        http 
      end

      def retrieve_payment_intent(payment_intent_id)
        url = prepare_url("#{PAYMENT_INTENTS}/#{payment_intent_id}")
        http = prepare_http(url)

        request = Net::HTTP::Get.new(url)
        request["Accept"] = 'application/json'
        request.basic_auth(SECRET_KEY, '')

        response = http.request(request)

        return JSON.parse response.read_body if response.is_a? Net::HTTPOK
        raise BadRequest
      end

      def payment_success?(response) 
        response['data']['attributes']['status'] == 'succeeded'
      end

      def prepare_url(url)
        URI("#{BASE_URL}/#{url}")
      end

      def prepare_request(url, payload)
        request = Net::HTTP::Post.new(url)
        request["Accept"] = 'application/json'
        request["Content-Type"] = 'application/json'
        request.basic_auth(SECRET_KEY, '')
        request.body = payload.to_json
        request 
      end

      def create_payment_intent(amount, description='chapipay')
        payload = {
          data: {
            attributes: {
              amount: amount.to_i, 
              payment_method_allowed: ['card'], 
              payment_method_options: {
                card: {
                  request_three_d_secure: 'any', 
                }
              }, 
              currency: 'PHP', 
              description: description
            }
          }
        }

        url = prepare_url(PAYMENT_INTENTS)
        http = prepare_http(url)
        request = prepare_request(url, payload)
        response = http.request(request)
        p response.body
        return JSON.parse response.read_body if response.is_a? Net::HTTPOK
        raise BadRequest
      end

      def create_payment_method(card)
        payload = {
          data: {
            attributes: {
              details: {
                card_number: card[:card_number],
                exp_month: card[:exp_month].to_i,
                exp_year: card[:exp_year].to_i,
                cvc: card[:cvc],
              }, 
              type: 'card', 
              billing: {
                name: card[:name], 
                email: card[:email]
              }
            }
          }
        }
        url = prepare_url(PAYMENT_METHODS)
        http = prepare_http(url)
        request = prepare_request(url, payload)
        response = http.request(request)
        p response.body 
        return JSON.parse response.read_body if response.is_a? Net::HTTPOK
        raise BadRequest
      end

      def attach(payment_intent_id, payment_method_id, client_key)
        payload = {
          data: {
            attributes: {
              payment_method: payment_method_id, 
              client_key: client_key, 
              return_url: RETURN_URL
            }
          }
        }

        url = prepare_url("#{PAYMENT_INTENTS}/#{payment_intent_id}/attach")
        http = prepare_http(url)
        request = prepare_request(url, payload)
        response = http.request(request)

        return JSON.parse response.read_body if response.is_a? Net::HTTPOK
        raise BadRequest
      end
      
    end
  end
end
