module Adhoq
  class PreviewsController < ApplicationController
    layout false

    def create
      begin
        @result = Adhoq::Executor.new(params[:query]).execute
      rescue ActiveRecord::StatementInvalid => @statement_invalid
        render 'statement_invalid', status: :unprocessable_entity
      end
    end
  end
end
