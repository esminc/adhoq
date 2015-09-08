class CreateNoIdTables < ActiveRecord::Migration
  def change
    create_table :no_id_tables, id: false do |t|

      t.timestamps null: false
    end
  end
end
