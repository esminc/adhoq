require 'adhoq/concerns/time_based_orders'

module Adhoq
  class Query < ActiveRecord::Base
    include Adhoq::Concerns::TimeBasedOrders

    has_many :executions, dependent: :destroy, inverse_of: :query

    def execute!(report_format)
      executions.create! {|exe|
        exe.report_format = report_format
        exe.raw_sql       = query
      }.tap(&:generate_report!)
    end
  end
end
