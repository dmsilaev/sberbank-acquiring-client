require 'dry-initializer'
require 'dry-types'

module Sberbank
  module Acquiring
    class ValidationError < StandardError; end

    class BaseResource
      extend Dry::Initializer

      option :connection

      def request(path, params)
        connection.get do |req|
          req.path = path
          req.params.merge! params.map { |k, v| [camelize(k.to_s), v] }.to_h
        end.env.body
      end

      def params_validation_error!(result)
        messages = result.messages(full: true).values.flatten
        raise ValidationError.new(:code => 422, :messages => messages)
      end

      private

      def camelize(str)
        str.split('_')
           .map.with_index { |word, i| i.zero? ? word : word.capitalize }.join
      end
    end
  end
end
