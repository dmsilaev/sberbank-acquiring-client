require 'dry-initializer'
require 'dry-types'

require 'faraday'
require 'sberbank/acquiring/middleware'

begin
  require 'httplog'
rescue LoadError
  true
end

module Sberbank
  module Acquiring
    class Client
      extend Dry::Initializer

      option  :api_url, default: -> { 'https://3dsec.sberbank.ru' }
      option  :api_username
      option  :api_password

      def connection
        @faraday ||= Faraday.new(connection_options) do |conn|
          conn.response :error
          conn.response :json
          conn.adapter Faraday.default_adapter
        end
      end

      def method_missing(name, *args, &block)
        if self.class.resources.keys.include?(name)
          resources[name] ||= self.class.resources[name].new(connection: connection)
          resources[name]
        else
          super
        end
      end

      def resources
        @resources ||= {}
      end

      def self.resources
        {
          orders: OrderResource
        }
      end

    private
      def connection_options
        {
          :url => api_url,
          :params => {
            'userName' => api_username,
            'password' => api_password
          },
          :headers => {
            :content_type => 'application/json'
          }
        }
      end
    end
  end
end
