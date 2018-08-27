require_relative 'base_schema'

module Sberbank
  module Acquiring
    OrderRegisterSchema = Dry::Validation.Schema(BaseSchema) do
      configure do
        def email?(value)
          true
        end

        def phone?(value)
          true
        end
      end

      required(:session_id).filled(:str?)
      required(:recommendation_id).filled(:str?)
      required(:payer_name).filled(:str?)
      required(:payer_phone).filled(:str?, :phone?)
      required(:payer_email).filled(:str?, :email?)
    end
  end
end
