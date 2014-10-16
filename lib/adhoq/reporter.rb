module Adhoq
  module Reporter
    autoload 'Xlsx', 'adhoq/reporter/xlsx'

    class << self
      def generate(execution)
        executor = Executor.new(execution.raw_sql)
        reporter = lookup(execution.report_format).new(executor.execute)

        reporter.build_report
      end

      def lookup(format)
        @map ||= {'xlsx' => Adhoq::Reporter::Xlsx}
        @map[format]
      end
    end
  end
end
