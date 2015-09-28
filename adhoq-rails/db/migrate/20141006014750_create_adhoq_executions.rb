class CreateAdhoqExecutions < ActiveRecord::Migration
  def change
    create_table :adhoq_executions do |t|
      t.belongs_to :query,          null: false
      t.text       :raw_sql,        null: false
      t.string     :report_format,  null: false
      t.string     :status,         null: false, default: 'requested'
      t.text       :log

      t.timestamps null: false
    end
  end
end
