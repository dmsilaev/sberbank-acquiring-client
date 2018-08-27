require_relative 'base_schema'

module Sberbank
  module Acquiring
    OrderRegisterSchema = Dry::Validation.Schema(BaseSchema) do
      required(:order_number).filled(:str?)
      required(:amount).filled(:str?)
      optional(:currency).filled(:str?)
      required(:return_url).filled(:str?)
      optional(:fail_url).filled(:str?)
      optional(:description).filled(:str?)
      optional(:language).filled(:str?)
      optional(:page_view).filled(:str?)
      optional(:client_id).filled(:str?)
      optional(:merchant_login).filled(:str?)
      optional(:json_params).filled(:str?)
      optional(:session_timeout_secs).filled(:str?)
      optional(:expiration_date).filled(:str?)
      optional(:binding_id).filled(:str?)
      optional(:features).filled(:str?)
    end

    OrderCancelSchema = Dry::Validation.Schema(BaseSchema) do
      required(:order_id).filled(:str?)
      optional(:language).filled(:str?)
    end

    OrderRefundSchema = Dry::Validation.Schema(BaseSchema) do
      required(:order_id).filled(:str?)
      required(:amount).filled(:str?)
    end

    OrderGetStatusSchema = Dry::Validation.Schema(BaseSchema) do
      required(:order_id).filled(:str?)
      required(:language).filled(:str?)
    end
  end
end
