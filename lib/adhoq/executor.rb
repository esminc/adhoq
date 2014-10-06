module Adhoq
  class Executor
    class << self
      def select(query)
        current_connection.send(:select, query)
      end

      def current_connection
        ActiveRecord::Base.connection
      end
    end

    def initialize(query)
      @query = query
    end

    def execute
      wrap_result(self.class.select(@query))
    end

    private

    def wrap_result(ar_result)
      Adhoq::Result.new(ar_result.columns, ar_result.rows)
    end
  end
end
