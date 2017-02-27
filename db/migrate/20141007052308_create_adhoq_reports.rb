major, minor, _ = Rails.version.split('.').map(&:to_i)
migration_class = (major > 5 || major == 5 && minor >= 1) ? ActiveRecord::Migration[4.2] : ActiveRecord::Migration

class CreateAdhoqReports < migration_class
  def change
    create_table :adhoq_reports do |t|
      t.belongs_to :execution,    null: false, index: true
      t.string     :identifier,   null: false
      t.time       :generated_at, null: false
      t.string     :storage,      null: false

      t.timestamps null: false
    end
  end
end
