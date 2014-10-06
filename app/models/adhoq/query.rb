module Adhoq
  class Query < ActiveRecord::Base
    def execute
      Adhoq::Executor.new(query).execute
    end
  end
end
