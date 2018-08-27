require 'faraday'

module Sberbank
  module Acquiring
    module Middleware
      autoload :ParseJson, 'sberbank/acquiring/middleware/response/parse_json'
      autoload :FlattenJson, 'sberbank/acquiring/middleware/response/flatten_json'
      autoload :HandleError, 'sberbank/acquiring/middleware/response/handle_error'

      if Faraday::Middleware.respond_to?(:register_middleware)
        Faraday::Response.register_middleware \
          :json   => lambda { ParseJson },
          :flatten => lambda { FlattenJson },
          :error  => lambda { HandleError }
      end
    end
  end
end
