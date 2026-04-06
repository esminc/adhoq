module Adhoq
  class Configuration
    class_attribute :storage
    self.storage = [:on_the_fly]
    class_attribute :base_controller
    self.base_controller = 'ApplicationController'
    class_attribute :authorization
    class_attribute :authorization_failure_action
    class_attribute :current_user
    class_attribute :database_connection
    class_attribute :hidden_model_names
    class_attribute :hide_rows_count
    class_attribute :async_execution
    class_attribute :job_queue_name

    def callablize(name)
      if (c = public_send(name)).respond_to?(:call)
        c
      else
        c.to_proc
      end
    end

    def async_execution?
      defined?(ActiveJob) && Adhoq.config.async_execution
    end
  end
end
