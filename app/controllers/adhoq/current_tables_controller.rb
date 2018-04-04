module Adhoq
  class CurrentTablesController < Adhoq::ApplicationController
    before_action :eager_load_models

    def index
      hidden_model_names = Array(Adhoq.config.hidden_model_names)
      hidden_model_names << 'ActiveRecord::SchemaMigration'
      hidden_model_names << 'ApplicationRecord'

      @ar_classes = ActiveRecord::Base.descendants.
        reject {|klass| klass.abstract_class? || hidden_model_names.include?(klass.name) || klass.name.nil? }.
        sort_by(&:name)

      respond_to do |format|
        format.html { render layout: false }
        format.json { render json: tables_as_json(@ar_classes) }
      end
    end

    private

    def tables_as_json(ar_classes)
      ar_classes.map {|ar_class|
        {
          table_name: ar_class.table_name,
          columns: ar_class.columns.map {|column|
            {
              name: column.name,
              type: column.type,
              primary_key: column.name == ar_class.primary_key,
              null: column.null,
              limit: column.limit,
              default: column.default
            }
          }
        }
      }
    end

    def eager_load_models
      return unless Rails.env.development?
      [Rails.application, Adhoq::Engine].each(&:eager_load!)
    end
  end
end
