module Adhoq
  class Report
    autoload 'XlsxReporter', 'adhoq/report/xlsx_reporter'

    def initialize(execution)
      @execution = execution
    end

    def data
      @data ||= format_reporter.new(executor.execute).build_report
    end

    private

    def executor
      Executor.new(@execution.raw_sql)
    end

    def format_reporter
      XlsxReporter
    end
  end
end
