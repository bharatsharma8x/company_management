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

ActiveRecord::Schema.define(version: 2023_05_03_082358) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "departments", force: :cascade do |t|
    t.string "dep_name"
    t.integer "num_of_employee"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "employees", force: :cascade do |t|
    t.string "f_name"
    t.string "l_name"
    t.date "dob"
    t.string "email"
    t.text "address"
    t.bigint "contact_no"
    t.string "designation"
    t.date "hire_date"
    t.date "resign_date"
    t.integer "salary"
    t.integer "ctc"
    t.bigint "bank_account_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "periferals", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "quantity"
    t.string "assign_to"
    t.integer "supplier_id"
    t.integer "manufacture_id"
    t.date "delivery_date"
    t.date "order_date"
    t.date "warranty_start_date"
    t.integer "warranty_duration"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
