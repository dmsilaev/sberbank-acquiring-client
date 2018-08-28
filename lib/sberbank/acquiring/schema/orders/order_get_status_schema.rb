require_relative '../base_schema'

module Sberbank
  module Acquiring
    OrderGetStatusSchema = Dry::Validation.Schema(BaseSchema) do
      required(:order_id).filled(:str?)
      optional(:language).filled(:str?)
    end
  end
end
