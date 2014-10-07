module Adhoq
  class QueriesController < ApplicationController
    def index
      @queries = Adhoq::Query.recent_first
    end

    def show
      @query = Adhoq::Query.find(params[:id])
    end

    def new
      @query = Adhoq::Query.new
    end
  end
end
