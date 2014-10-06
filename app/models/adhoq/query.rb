module Adhoq
  class Query < ActiveRecord::Base
    def execute
      Adhoq::Executor.new(query).execute
    end

    scope :recent_first, -> { order("#{quoted_table_name}.updated_at DESC") }
  end
end
