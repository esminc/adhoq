module Adhoq
  module TimeBasedOrders
    extend ActiveSupport::Concern

    included do
      scope :recent_first, -> { order(arel_table[:updated_at].desc) }
    end
  end
end
