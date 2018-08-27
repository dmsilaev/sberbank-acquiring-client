require 'dry-initializer'
require 'dry-types'

require 'json'

module Sberbank
  module Acquiring
    module Middleware
      class ParseJson
        extend Dry::Initializer

        param :app

        def call(request_env)
          app.call(request_env).on_complete do |response_env|
            if response_env.status == 200
              response_env[:body] = parse(response_env.body)
            else
              response_env[:body] = error(response_env.status)
            end
          end
        end

        def parse(body)
          parsed_body = JSON.parse(body, symbolize_names: true)
          parsed_body.transform_keys { |key| key.to_s.underscore.to_sym }
        end

        def error(code)
          Hash(
            :result => {
              :code => code,
              :message => 'Неизвестная ошибка'
            }
          )
        end
      end
    end
  end
end
