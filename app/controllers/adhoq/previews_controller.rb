module Adhoq
  class PreviewsController < ApplicationController
    layout false

    def create
      begin
        @result = Adhoq::Executor.new(params[:query]).execute
      rescue ActiveRecord::StatementInvalid => ex
        @statement_invalid = ex
        render 'statement_invalid'
      end
    end
  end
end
