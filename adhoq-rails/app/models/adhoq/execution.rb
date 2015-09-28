module Adhoq
  class Execution < ActiveRecord::Base
    include Adhoq::TimeBasedOrders

    belongs_to :query
    has_one    :report, dependent: :destroy, inverse_of: :execution

    delegate   :supported_formats, to: Adhoq::Reporter

    def generate_report!
      build_report.generate!
      update_attributes(status: :success)
    rescue
      update_attributes(status: :failure)
    end

    def name
      [query.name, created_at.strftime('%Y%m%d-%H%M%S'), report_format].join('.')
    end

    def success?
      report.try(:available?) || status == "success"
    end
  end
end
