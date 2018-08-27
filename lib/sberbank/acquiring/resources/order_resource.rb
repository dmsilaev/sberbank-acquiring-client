require_relative './base_resource'
require_relative '../schema/order_schema'
require_relative '../mappings/order_mapping'

module Sberbank
  module Acquiring
    class OrderResource < BaseResource
      def initialize(*args)
        @mapper = OrderMapping.new
        super
      end

      def register(params)
        path = '/payment/rest/register.do'

        result = OrderRegisterSchema.(params)
        params_validation_error!(result)  if result.failure?

        response = request(path, result.output)
        @mapper.extract_single(response)
      end
    end
  end
end
