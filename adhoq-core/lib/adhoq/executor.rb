module Adhoq
  class Executor
    autoload 'ConnectionWrapper', 'adhoq/executor/connection_wrapper'

    def initialize(query)
      @connection = ConnectionWrapper.new
      @query = query
    end

    def execute
      wrap_result(@connection.select(@query))
    end

    def explain
      @connection.explain(@query)
    end

    private

    def wrap_result(ar_result)
      Adhoq::Result.new(ar_result.columns, ar_result.rows)
    end
  end
end
