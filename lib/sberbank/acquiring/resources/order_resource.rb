require_relative './base_resource'
require_relative '../schema/orders/order_cancel_schema'
require_relative '../schema/orders/order_get_status_schema'
require_relative '../schema/orders/order_refund_schema'
require_relative '../schema/orders/order_register_schema'
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

      def cancel(params)
        path = '/payment/rest/reverse.do'

        result = OrderCancelSchema.(params)
        params_validation_error!(result)  if result.failure?

        response = request(path, result.output)
        @mapper.extract_single(response)
      end

      def refund(params)
        path = '/payment/rest/refund.do'

        result = OrderRefundSchema.(params)
        params_validation_error!(result)  if result.failure?

        response = request(path, result.output)
        @mapper.extract_single(response)
      end

      def get_status(params)
        path = '/payment/rest/getOrderStatus.do'

        result = OrderGetStatusSchema.(params)
        params_validation_error!(result)  if result.failure?

        response = request(path, result.output)
        @mapper.extract_single(response)
      end
    end
  end
end
