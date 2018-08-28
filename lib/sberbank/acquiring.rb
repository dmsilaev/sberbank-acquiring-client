require "sberbank/acquiring/version"
require "active_support/all"

module Sberbank
  module Acquiring
    autoload :Client, 'sberbank/acquiring/client'

    # # Resources
    autoload :OrderResource, 'sberbank/acquiring/resources/order_resource'
  end
end
