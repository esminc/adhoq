module Adhoq
  class Executor
    class << self
      def select(query)
        with_sandbox do
          current_connection.exec_query(query)
        end
      end

      def explain(query)
        with_sandbox do
          current_connection.explain(query)
        end
      end

      def current_connection
        ActiveRecord::Base.connection
      end

      def with_sandbox
        result = nil
        ActiveRecord::Base.transaction do
          result = yield
          raise ActiveRecord::Rollback
        end
        result
      end
    end

    def initialize(query)
      @query = query
    end

    def execute
      wrap_result(self.class.select(@query))
    end

    def explain
      self.class.explain(@query)
    end

    private

    def wrap_result(ar_result)
      Adhoq::Result.new(ar_result.columns, ar_result.rows)
    end
  end
end
