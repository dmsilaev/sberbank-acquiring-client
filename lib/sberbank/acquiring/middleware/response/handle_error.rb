require 'dry-initializer'
require 'dry-types'

require 'json'

module Sberbank
  module Acquiring
    module Middleware
      class Error < StandardError; end

      class HandleError
        extend Dry::Initializer

        param :app

        def call(request_env)
          app.call(request_env).on_complete do |response_env|
            handle_error!(response_env.body)
          end
        rescue Faraday::ConnectionFailed => e
          handle_connection_failed(e)
        end

        def handle_error!(body)
          code = body.dig(:result, :code)
          error_msg = body.dig(:error) || ""
          message = body.dig(:result, :message)

          if code && code.to_i != 0
            raise Error.new :code => code, :messages => [message]
          end

          if !error_msg.empty?
            raise Error.new :code => code, :messages => [error_msg]
          end
        end

        def handle_connection_failed(e)
          raise Error.new :messages => [e.message]
        end
      end
    end
  end
end
