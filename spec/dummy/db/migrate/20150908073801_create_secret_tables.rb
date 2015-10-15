class CreateSecretTables < ActiveRecord::Migration
  def change
    create_table :secret_tables do |t|

      t.timestamps null: false
    end
  end
end
