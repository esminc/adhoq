module Adhoq
  class Report < ActiveRecord::Base
    BUFSIZE = 10.kilobytes.to_i

    belongs_to :execution

    delegate :name,      to: 'execution'
    delegate :mime_type, to: :reporter

    def generate!(storage = Adhoq.current_storage)
      self.identifier   = generate_and_persist_report!(storage)
      self.generated_at = Time.now
      self.storage      = storage.identifier

      save!
    end

    def data(storage = Adhoq.current_storage)
      storage.get(identifier)
    end

    private

    def reporter
      {'xlsx' => Adhoq::Reporter::Xlsx}[execution.report_format]
    end

    def generate_and_persist_report!(storage)
      storage.store(".#{execution.report_format}") do |file, *|
        executor = Executor.new(execution.raw_sql)

        reporter.new(executor.execute).build_report.each(BUFSIZE) do |chunk|
          file.write chunk
        end
      end
    end
  end
end
