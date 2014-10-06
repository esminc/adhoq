module Adhoq
  module Concerns
    module TimeBasedOrders
      extend ActiveSupport::Concern

      included do
        scope :recent_first, -> { order("#{quoted_table_name}.updated_at DESC") }
      end
    end
  end
end
