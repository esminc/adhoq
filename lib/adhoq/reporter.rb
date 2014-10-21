module Adhoq
  module Reporter
    autoload 'Csv',  'adhoq/reporter/csv'
    autoload 'Xlsx', 'adhoq/reporter/xlsx'

    class << self
      def generate(execution)
        executor = Executor.new(execution.raw_sql)
        reporter = lookup(execution.report_format).new(executor.execute)

        reporter.build_report
      end

      def lookup(format)
        reporters[format.to_s]
      end

      def supported_formats
        reporters.keys.sort
      end

      private

      def reporters
        @reporters ||= {'xlsx' => Adhoq::Reporter::Xlsx, 'csv' => Adhoq::Reporter::Csv}
      end
    end
  end
end
