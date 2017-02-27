major, minor, _ = Rails.version.split('.').map(&:to_i)
migration_class = (major > 5 || major == 5 && minor >= 1) ? ActiveRecord::Migration[4.2] : ActiveRecord::Migration

class CreateNoIdTables < migration_class
  def change
    create_table :no_id_tables, id: false do |t|

      t.timestamps null: false
    end
  end
end
