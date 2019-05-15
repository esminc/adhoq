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
      @query = Adhoq::Query.create!(query_attributes)

      redirect_to @query
    end

    def edit
      @query = Adhoq::Query.find(params[:id])
    end

    def update
      @query = Adhoq::Query.find(params[:id])
      @query.update!(query_attributes)

      redirect_to @query
    end

    def destroy
      Adhoq::Query.find(params[:id]).destroy!
      redirect_to action: :index
    end

    private

    def query_attributes
      params.require(:query).permit(:name, :description, :query)
    end
  end
end
