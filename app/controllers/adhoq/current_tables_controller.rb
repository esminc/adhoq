module Adhoq
  class CurrentTablesController < Adhoq::ApplicationController
    before_action :eager_load_models

    def index
      hidden_model_names = Array(Adhoq.config.hidden_model_names)
      hidden_model_names << 'ActiveRecord::SchemaMigration'
      hidden_model_names << 'ApplicationRecord'

      @ar_classes = ActiveRecord::Base.descendants.
        reject {|klass| hidden_model_names.include?(klass.name) }.
        sort_by(&:name)

      render layout: false
    end

    private

    def eager_load_models
      return unless Rails.env.development?
      [Rails.application, Adhoq::Engine].each(&:eager_load!)
    end
  end
end
