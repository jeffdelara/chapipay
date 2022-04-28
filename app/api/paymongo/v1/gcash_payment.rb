module Paymongo
  module V1
    class GcashPayment
      include ApiExceptions
      BASE_URL = 'https://api.paymongo.com/v1'
      SOURCES = 'sources'
      PAYMENTS = 'payments'
      SUCCESS_URL = Settings.PAYMONGO_GCASH_SUCCESS_URL
      FAILED_URL = Settings.PAYMONGO_GCASH_FAILED_URL
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

      def prepare_request(url, paymongo_data, api_key)
        request = Net::HTTP::Post.new(url)
        request["Accept"] = 'application/json'
        request["Content-Type"] = 'application/json'
        request.basic_auth(api_key, '')
        request.body = paymongo_data.to_json
        request
      end

      def retrieve_source(source_id)
        url = prepare_url("#{SOURCES}/#{source_id}")
        http = prepare_http(url)

        request = Net::HTTP::Get.new(url)
        request["Accept"] = 'application/json'
        request.basic_auth(PUBLIC_KEY, '')

        response = http.request(request)

        return JSON.parse response.read_body if response.is_a? Net::HTTPOK
        raise BadRequest
      end

      def retrieve_payment(payment_id)
        url = prepare_url("#{PAYMENTS}/#{payment_id}")
        http = prepare_http(url)

        request = Net::HTTP::Get.new(url)
        request["Accept"] = 'application/json'
        request.basic_auth(SECRET_KEY, '')

        response = http.request(request)

        return JSON.parse response.read_body if response.is_a? Net::HTTPOK
        raise BadRequest
      end

      def create_source(amount)
        payload = {
          data: {
            attributes: {
              amount: amount.to_i,
              redirect: {
                success: SUCCESS_URL,
                failed: FAILED_URL
                },
              type: "gcash",
              currency:"PHP"
            }
          }
        }

        url = prepare_url(SOURCES)
        http = prepare_http(url)
        request = prepare_request(url, payload, PUBLIC_KEY)
        response = http.request(request)

        return JSON.parse response.read_body if response.is_a? Net::HTTPOK
        raise BadRequest
      end

      def create_payment(amount, src_id, description="GCash Payment")
        payment = {
          data: {
            attributes: {
              amount: amount.to_i,
              source: {
                id: src_id,
                type: 'source'
                },
              currency: 'PHP',
              description: description
              }
            }
          }

        url = prepare_url(PAYMENTS)
        http = prepare_http(url)
        request = prepare_request(url, payment, SECRET_KEY)
        response = http.request(request)

        return JSON.parse response.read_body if response.is_a? Net::HTTPOK
        raise BadRequest
      end
    end
  end
end
