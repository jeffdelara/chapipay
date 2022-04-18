module Paymongo
  module V1
    class CardPayment
      include ApiExceptions
      BASE_URL = 'https://api.paymongo.com/v1/'
      PAYMENT_INTENTS = 'payment_intents'
      PAYMENT_METHODS = 'payment_methods'
      PUBLIC_KEY = Rails.application.credentials.paymongo[:public_key] 
      SECRET_KEY = Rails.application.credentials.paymongo[:secret_key]

      def prepare_http(url)
        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = true
        http 
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

      def create_payment_intent(amount, description='donate')
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

        return JSON.parse response.read_body if response.is_a? Net::HTTPOK
        raise BadRequest
      end

      def create_payment_method(card, billing=nil)
        payload = {
          data: {
            attributes: {
              details: {
                card_number: card[:card_number],
                exp_month: card[:exp_month],
                exp_year: card[:exp_year],
                cvc: card[:cvc],
              }, 
              type: 'card', 
              billing: {
                name: billing[:name], 
                email: billing[:email]
              }
            }
          }
        }
        url = prepare_url(PAYMENT_METHODS)
        http = prepare_http(url)
        request = prepare_request(url, payload)
        response = http.request(request)

        return JSON.parse response.read_body if response.is_a? Net::HTTPOK
        raise BadRequest
      end

      def attach(payment_intent_id, payment_method_id, client_key)
        payload = {
          data: {
            attributes: {
              payment_method: payment_method_id, 
              client_key: client_key
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
