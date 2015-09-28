if defined?(ActiveJob)
  class Adhoq::ExecuteJob < ActiveJob::Base
    queue_as do
      Adhoq.config.job_queue_name.try(:to_sym) || :default
    end

    def perform(query, *args)
      query.execute!(*args)
    end
  end
end
