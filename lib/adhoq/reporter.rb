module Adhoq
  module Reporter
    class UnsupportedFormat < Adhoq::Error; end

    autoload 'Csv',  'adhoq/reporter/csv'
    autoload 'Json', 'adhoq/reporter/json'
    autoload 'Xlsx', 'adhoq/reporter/xlsx'

    class << self
      def generate(execution)
        executor = Executor.new(execution.raw_sql)
        reporter = lookup(execution.report_format).new(executor.execute)

        reporter.build_report
      end

      def lookup(format)
        reporters[format.to_s] || raise(UnsupportedFormat)
      end

      def supported_formats
        reporters.keys.sort
      end

      private

      def reporters
        @reporters ||= {
          'csv'  => Adhoq::Reporter::Csv,
          'json' => Adhoq::Reporter::Json,
          'xlsx' => Adhoq::Reporter::Xlsx,
        }
      end
    end
  end
end
