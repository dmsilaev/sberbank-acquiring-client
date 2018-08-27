require 'dry-initializer'
require 'dry-types'

require 'faraday'
require 'acquiring/middleware'
require 'acquiring/utils/parameters'

begin
  require 'httplog'
rescue LoadError
  true
end

module Sberbank
  module Acquiring
    module Client
      extend Dry::Initializer

      option  :api_url
      option  :api_username
      option  :api_password

      def connection
        @faraday ||= Faraday.new(connection_options) do |conn|
          conn.response :error
          conn.response :flatten
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
          orders:OrderResource,
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
          },
          :request => {
            :params_encoder => AviaCenterPlane::NestedParamsEncoder
          }
        }
      end
    end
  end
end
