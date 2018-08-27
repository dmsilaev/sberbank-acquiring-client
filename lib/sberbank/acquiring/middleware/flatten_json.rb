require 'dry-initializer'
require 'dry-types'

require 'json'

module Sberbank
  module Acquiring
    module Middleware
      class FlattenJson
        extend Dry::Initializer

        param :app

        def call(request_env)
          app.call(request_env).on_complete do |response_env|
            response_env[:body] = flatten(response_env.body)
          end
        end

        def flatten(body)
          body.dig(:response) || body
        end
      end
    end
  end
end
