require_relative './base_mapping'

module Sberbank
  module Acquiring
    class OrderMapping < BaseMapping
      def extract_single(response)
        response
      end

      def extract_collection(response)
        response
      end
    end
  end
end
