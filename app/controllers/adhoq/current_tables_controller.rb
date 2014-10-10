module Adhoq
  class CurrentTablesController < Adhoq::ApplicationController
    before_filter :eager_load_models

    def index
      @ar_classes = ActiveRecord::Base.subclasses.sort_by(&:name)
    end

    private

    def eager_load_models
      return unless Rails.env.development?
      [Rails.application, Adhoq::Engine].each(&:eager_load!)
    end
  end
end
