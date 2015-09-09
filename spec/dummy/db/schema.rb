# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150908073801) do

  create_table "adhoq_executions", force: :cascade do |t|
    t.integer  "query_id",                            null: false
    t.text     "raw_sql",                             null: false
    t.string   "report_format",                       null: false
    t.string   "status",        default: "requested", null: false
    t.text     "log"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  create_table "adhoq_queries", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.text     "query"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "adhoq_reports", force: :cascade do |t|
    t.integer  "execution_id", null: false
    t.string   "identifier",   null: false
    t.time     "generated_at", null: false
    t.string   "storage",      null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "adhoq_reports", ["execution_id"], name: "index_adhoq_reports_on_execution_id"

  create_table "secret_tables", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
