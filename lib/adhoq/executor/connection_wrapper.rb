module Adhoq
  class Executor
    class ConnectionWrapper
      def initialize
      end

      def select(query)
        with_sandbox do |connection|
          connection.exec_query(query)
        end
      end

      def explain(query)
        with_sandbox do |connection|
          connection.explain(query)
        end
      end

      def with_connection
        connection = Adhoq.config.callablize(:database_connection).call
        yield(connection)
      end

      def with_sandbox
        result = nil
        with_connection do |connection|
          connection.transaction do
            result = yield(connection)
            raise ActiveRecord::Rollback
          end
        end
        result
      end
    end
  end
end
