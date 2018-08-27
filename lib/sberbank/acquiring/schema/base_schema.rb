require 'dry-validation'

module Sberbank
  module Acquiring
    module Types
      include Dry::Types.module
    end

    class BaseSchema < Dry::Validation::Schema
      # configure do |config|
      #   config.messages_file = '/my/app/config/locales/en.yml'
      #   config.messages = :i18n
      # end
    end

    class BaseForm < BaseSchema
      configure do
        config.type_specs = true
      end
    end

    Types::Coercible::AmountValue = Types::Coercible::Float.constructor do |value|
      value ? sprintf('%.2f', value.to_f) : value
    end
  end
end
