require 'dry-initializer'
require 'dry-types'

module Sberbank
  module Acquiring
    class BaseMapping
      def extract_single(response)
        response
      end

      def extract_collection(response)
        response
      end
    end
  end
end
