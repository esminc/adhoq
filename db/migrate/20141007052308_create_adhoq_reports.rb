class CreateAdhoqReports < ActiveRecord::Migration
  def change
    create_table :adhoq_reports do |t|
      t.belongs_to :execution,    null: false, index: true
      t.string     :identifier,   null: false
      t.time       :generated_at, null: false
      t.string     :storage,      null: false

      t.timestamps
    end
  end
end
