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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 0) do

  create_table "lab_order", :primary_key => "lab_order_id", :force => true do |t|
    t.string    "request_number",       :limit => 45
    t.string    "barcodes"
    t.string    "national_id",          :limit => 128
    t.string    "priority_code",        :limit => 45
    t.datetime  "date_collected"
    t.datetime  "date_received"
    t.integer   "patient_id"
    t.string    "result"
    t.datetime  "date_result_received"
    t.string    "test_code"
    t.timestamp "timestamp",                                          :null => false
    t.string    "test_unit"
    t.string    "colour",               :limit => 45
    t.string    "test_range"
    t.integer   "voided",                              :default => 0
  end

  add_index "lab_order", ["lab_order_id"], :name => "lab_order_id_UNIQUE", :unique => true

  create_table "lab_result", :primary_key => "lab_result_id", :force => true do |t|
    t.integer "patient_id"
    t.string  "national_id",    :limit => 45
    t.string  "test_code"
    t.string  "request_number", :limit => 45
    t.integer "voided",                       :default => 0
  end

  create_table "lab_result_details", :primary_key => "lab_result_details_id", :force => true do |t|
    t.integer   "lab_result_id"
    t.string    "field_name"
    t.string    "field_value"
    t.timestamp "timestamp",                                   :null => false
    t.integer   "voided",                       :default => 0
    t.string    "request_number"
    t.string    "test_code",      :limit => 45
  end

end
