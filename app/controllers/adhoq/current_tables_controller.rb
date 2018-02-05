module Adhoq
  class CurrentTablesController < Adhoq::ApplicationController
    before_action :eager_load_models

    def index
      hidden_model_names = Array(Adhoq.config.hidden_model_names)
      hidden_model_names << 'ActiveRecord::SchemaMigration'
      hidden_model_names << 'ApplicationRecord'

      ar_base_class = defined?(ApplicationRecord) ? ApplicationRecord : ActiveRecord::Base
      @ar_classes = ar_base_class.descendants.
        reject {|klass| klass.abstract_class? || hidden_model_names.include?(klass.name) || klass.name.nil? }.
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
