module Adhoq
  class Query < ApplicationRecord
    include Adhoq::TimeBasedOrders

    has_many :executions, dependent: :destroy, inverse_of: :query

    PARAMETER_PATTERN = /\$(?<name>\w+)|\${(?<name>\w+)}/i.freeze

    def execute!(report_format, query_parameters = {})
      ApplicationRecord.with_writable do
        executions.create! {|exe|
          exe.report_format = report_format
          exe.raw_sql       = substitute_query(query_parameters)
        }.tap(&:generate_report!)
      end
    end

    def parameters
      return @parameters if @parameters

      @parameters = query.scan(PARAMETER_PATTERN).each_with_object([]) do |(match1, match2), arr|
        name = match1 || match2

        arr << name.downcase
      end
    end

    def substitute_query(query_parameters)
      return query if parameters.empty?

      query_parameters = query_parameters.with_indifferent_access
      query.gsub(PARAMETER_PATTERN) do |_, arr|
        name = Regexp.last_match["name"]
        query_parameters[name]
      end
    end
  end
end
