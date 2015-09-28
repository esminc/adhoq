module Adhoq
  module ApplicationHelper
    def human(klass, attr = nil)
      if attr
        klass.human_attribute_name(attr)
      else
        klass.model_name.humanize
      end
    end

    def icon_fa(name, additional_classes = [])
      tag('i', class: ['fa', "fa-#{name}", *additional_classes])
    end

    def schema_version
      if defined?(ActiveRecord::SchemaMigration)
        ActiveRecord::SchemaMigration.maximum(:version)
      else
        connection = Adhoq::Executor::ConnectionWrapper.new
        result = connection.select("SELECT MAX(version) AS current_version FROM #{ActiveRecord::Migrator.schema_migrations_table_name}")
        result.rows.first.first
      end
    end

    # TODO extract into presenter
    def query_friendly_name(query)
      "Query: #{query.name}"
    end

    def table_order_key(ar_class)
      ar_class.primary_key || ar_class.columns.first.name
    end
  end
end
