module Adhoq
  class Execution < ApplicationRecord
    include Adhoq::TimeBasedOrders

    belongs_to :query
    has_one    :report, dependent: :destroy, inverse_of: :execution

    delegate   :supported_formats, to: Adhoq::Reporter

    def generate_report!
      ApplicationRecord.with_writable do
        build_report.generate!
        update_attributes(status: :success)
      end
    rescue
      ApplicationRecord.with_writable do
        update_attributes(status: :failure)
      end
    end

    def name
      [query.name, created_at.strftime('%Y%m%d-%H%M%S'), report_format].join('.')
    end

    def success?
      report.try(:available?) || status == "success"
    end
  end
end
