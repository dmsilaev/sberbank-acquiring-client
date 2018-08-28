require_relative '../base_schema'

module Sberbank
  module Acquiring
    OrderRefundSchema = Dry::Validation.Schema(BaseSchema) do
      required(:order_id).filled(:str?)
      required(:amount).filled(:str?)
    end
  end
end
