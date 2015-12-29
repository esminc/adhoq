module Adhoq
  class ExecutionsController < Adhoq::ApplicationController
    def show
      @execution = current_query.executions.where(id: params[:id], report_format: params[:format]).first!

      respond_report(@execution.report)
    end

    def create
      async_execution? ? asynced_create : synced_create
    end

    private

    def synced_create
      @execution = current_query.execute!(params[:execution][:report_format], query_parameters)

      if @execution.report.on_the_fly?
        respond_report(@execution.report)
      else
        redirect_to current_query
      end
    end

    def asynced_create
      Adhoq::ExecuteJob.perform_later(current_query, params[:execution][:report_format], query_parameters)
      redirect_to current_query
    end

    def current_query
      @query ||= Adhoq::Query.find(params[:query_id])
    end

    def respond_report(report)
      if Adhoq.current_storage.direct_download?
        redirect_to report.data_url
      else
        send_data report.data, type: report.mime_type, filename: report.name, disposition: 'attachment'
      end
    end

    def async_execution?
      Adhoq.config.async_execution? && !Adhoq.current_storage.is_a?(Adhoq::Storage::OnTheFly)
    end

    def query_parameters
      params[:parameters] || HashWithIndifferentAccess.new
    end
  end
end
