module Adhoq
  class Query < ActiveRecord::Base
    include Adhoq::TimeBasedOrders

    has_many :executions, dependent: :destroy, inverse_of: :query

    PARAMETER_PATTERN = /\$(?<name>\w+)::(?<type>\w+)/i.freeze
    SUPPORT_PARAMETER_TYPES = %w(text string int float date datetime).freeze

    def execute!(report_format, query_parameters = {})
      executions.create! {|exe|
        exe.report_format = report_format
        exe.raw_sql       = sanitized_query(query_parameters)
      }.tap(&:generate_report!)
    end

    def parameters
      return @parameters if @parameters

      @parameters = query.scan(PARAMETER_PATTERN).each_with_object([]) do |(name, type), arr|
        if SUPPORT_PARAMETER_TYPES.include?(type.downcase)
          arr << {name: name.downcase, type: type.downcase}
        end
      end
    end

    def sanitized_query(query_parameters)
      return query if parameters.empty?

      casted = query_parameters.each_with_object(HashWithIndifferentAccess.new) do |(name, value_and_type), hash|
        hash[name] = cast_query_parameter(value_and_type)
      end

      base_query = query.gsub(PARAMETER_PATTERN) do
        match = Regexp.last_match
        ":#{match[:name]}"
      end

      self.class.send(:sanitize_sql, [base_query, casted])
    end

    private

    def cast_query_parameter(value_and_type)
      value = value_and_type[:value]
      type = value_and_type[:type]

      case type
      when "string", "text"
        value.to_s
      when "int"
        value.to_i
      when "float", "double"
        value.to_f
      when "date"
        value.to_date
      when "datetime"
        Time.zone.parse(value)
      end
    end
  end
end
