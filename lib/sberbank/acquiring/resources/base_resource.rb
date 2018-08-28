require 'dry-initializer'
require 'dry-types'
require 'active_support/inflector'

module Sberbank
  module Acquiring
    class ValidationError < StandardError; end

    class BaseResource
      extend Dry::Initializer

      option :connection

      def request(path, params)
        connection.get do |req|
          req.path = path
          req.params.merge! params.deep_transform_keys { |key| key.to_s.camelize(:lower).to_sym }
        end.env.body
      end

      def params_validation_error!(result)
        messages = result.messages(full: true).values.flatten
        raise ValidationError.new(:code => 422, :messages => messages)
      end
    end
  end
end
