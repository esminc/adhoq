module Adhoq
  class Report < ActiveRecord::Base
    belongs_to :execution

    delegate :name, to: 'execution'

    def generate!(storage = Adhoq.current_storage)
      self.identifier   = generate_and_persist_report!(storage)
      self.generated_at = Time.now
      self.storage      = storage.identifier

      save!
    end

    def on_the_fly?
      storage.start_with?(Adhoq::Storage::OnTheFly::PREFIX)
    end

    def available?
      identifier.present? && (storage == Adhoq.current_storage.identifier)
    end

    def data(storage = Adhoq.current_storage)
      storage.get(identifier)
    end

    def data_url(storage = Adhoq.current_storage)
      storage.get_url(self)
    end

    def mime_type
      Adhoq::Reporter.lookup(execution.report_format).mime_type
    end

    private

    def generate_and_persist_report!(storage)
      storage.store(".#{execution.report_format}") {
        Adhoq::Reporter.generate(execution)
      }
    end
  end
end
