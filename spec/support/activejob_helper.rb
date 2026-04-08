RSpec.configure do |config|
  config.around(:each, async_execution: true) do |ex|
    current_async_execution = Adhoq.config.async_execution

    Adhoq.config.async_execution = true

    ex.call

    Adhoq.config.async_execution = current_async_execution
  end

  config.around(:each, active_job_test_adapter: true) do |ex|
    current_execute_job_queue_adapter = Adhoq::ExecuteJob.queue_adapter

    Adhoq::ExecuteJob.queue_adapter = ActiveJob::QueueAdapters::TestAdapter.new
    Adhoq::ExecuteJob.queue_adapter.perform_enqueued_jobs = true

    ex.call

    Adhoq::ExecuteJob.queue_adapter.performed_jobs.clear
    Adhoq::ExecuteJob.queue_adapter = current_execute_job_queue_adapter
  end
end
