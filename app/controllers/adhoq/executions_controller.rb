module Adhoq
  class ExecutionsController < ApplicationController
    def show
      @execution = current_query.executions.where(id: params[:id], report_format: params[:format]).first!

      report = @execution.report
      send_data report.data, type: report.mime_type
    end

    def create
      @execution = current_query.execute!(params[:execution][:report_format])

      redirect_to [current_query, @execution, format: @execution.report_format]
    end

    private

    def current_query
      @query ||= Adhoq::Query.find(params[:query_id])
    end
  end
end
