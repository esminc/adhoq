module Adhoq
  class Executor
    class ConnectionWrapper
      attr_reader :connection

      def initialize
        @connection = Adhoq.config.callablize(:database_connection).call
      end

      def select(query)
        with_sandbox do
          connection.exec_query(query)
        end
      end

      def explain(query)
        with_sandbox do
          connection.explain(query)
        end
      end

      def with_sandbox
        result = nil
        connection.transaction do
          result = yield
          raise ActiveRecord::Rollback
        end
        result
      end
    end
  end
end
