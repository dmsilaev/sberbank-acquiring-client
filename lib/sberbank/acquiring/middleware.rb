require 'faraday'

module Sberbank
  module Acquiring
    module Middleware
      autoload :ParseJson, 'sberbank/acquiring/middleware/response/parse_json'
      autoload :HandleError, 'sberbank/acquiring/middleware/response/handle_error'

      if Faraday::Middleware.respond_to?(:register_middleware)
        Faraday::Response.register_middleware \
          :json   => lambda { ParseJson },
          :error  => lambda { HandleError }
      end
    end
  end
end
