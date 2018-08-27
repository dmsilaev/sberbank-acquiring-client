require "sberbank/acquiring/version"
require "active_support/all"

module Sberbank
  module Acquiring
    autoload :Client, 'sberbank/acquiring/client'

    # # Resources
    autoload :OrderResource, 'sberbank/acquiring/resources/order_resource'
    # autoload :FareResource, 'avia_center_plane/resources/fare_resource'
    # autoload :BookResource, 'avia_center_plane/resources/book_resource'
    # autoload :TicketResource, 'avia_center_plane/resources/ticket_resource'
    # autoload :PaymentResource, 'avia_center_plane/resources/payment_resource'
    # autoload :RefundResource, 'avia_center_plane/resources/refund_resource'
  end
end
