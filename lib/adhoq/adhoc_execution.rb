# Provides polymorphic API with Adhoc::Execution AR Model
module Adhoq
  class AdhocExecution
    attr_reader :report_format, :raw_sql

    def initialize(report_format, raw_sql)
      @report_format = report_format
      @raw_sql       = raw_sql
    end
  end
end
