module Adhoq
  class QueriesController < Adhoq::ApplicationController
    def index
      @queries = Adhoq::Query.recent_first
    end

    def show
      @query = Adhoq::Query.find(params[:id])
    end

    def new
      @query = Adhoq::Query.new
    end

    def create
      ApplicationRecord.with_writable do
        @query = Adhoq::Query.create!(query_attributes)
      end

      redirect_to @query
    end

    def edit
      @query = Adhoq::Query.find(params[:id])
    end

    def update
      @query = Adhoq::Query.find(params[:id])
      ApplicationRecord.with_writable do
        @query.update_attributes!(query_attributes)
      end

      redirect_to @query
    end

    def destroy
      ApplicationRecord.with_writable do
        Adhoq::Query.find(params[:id]).destroy!
      end
      redirect_to action: :index
    end

    private

    def query_attributes
      params.require(:query).permit(:name, :description, :query)
    end
  end
end
