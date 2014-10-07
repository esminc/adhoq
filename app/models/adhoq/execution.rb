require 'adhoq/concerns/time_based_orders'

module Adhoq
  class Execution < ActiveRecord::Base
    include Adhoq::Concerns::TimeBasedOrders

    belongs_to :query
    has_one    :report, dependent: :destroy, inverse_of: :execution

    def supported_formats
      %w[xlsx]
    end

    def generate_report!
      build_report.generate!
    end

    def name
      [query.name, created_at.strftime('%Y%m%d-%H%M%S'), report_format].join('.')
    end
  end
end
