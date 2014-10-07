module Adhoq
  class Report
    class NotGeneratedYet < Adhoq::Error
    end

    autoload 'XlsxReporter', 'adhoq/report/xlsx_reporter'

    delegate :name,      to: '@execution'
    delegate :mime_type, to: :format_reporter

    def initialize(execution, storage = Adhoq.current_strage)
      @execution = execution
      @storage   = storage
    end

    def generate!
      @storage.store(".#{@execution.report_format}") do |file, identifier|
        file.write(format_reporter.new(executor.execute).build_report)

        @execution.generated!(identifier: identifier, generated_at: Time.now)
      end
    end

    def data
      if ident = execution.identifier.presence
        @storage.get(executor.identifier)
      else
        raise NotGeneratedYet if execution.identifier.blank?
      end
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
