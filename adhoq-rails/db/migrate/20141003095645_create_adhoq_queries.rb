class CreateAdhoqQueries < ActiveRecord::Migration
  def change
    create_table :adhoq_queries do |t|
      t.string :name
      t.string :description
      t.text :query

      t.timestamps null: false
    end
  end
end
