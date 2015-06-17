module Adhoq
  class PreviewsController < Adhoq::ApplicationController
    layout false

    def create
      begin
        query = Adhoq::Query.new(query: params[:query])
        raw_query = query.sanitized_query(params[:parameters])
        @result = Adhoq::Executor.new(raw_query).execute
      rescue ActiveRecord::StatementInvalid => @statement_invalid
        render 'statement_invalid', status: :unprocessable_entity
      end
    end
  end
end
