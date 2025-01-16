# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2025_01_16_033146) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.time "time"
    t.date "date"
    t.string "location"
    t.integer "capacity"
    t.text "what_to_bring"
    t.text "rules"
    t.text "notes"
    t.decimal "cost", precision: 8, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "events", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.time "time"
    t.date "date"
    t.string "location"
    t.date "rsvp_deadline"
    t.boolean "childcare"
    t.string "sponsors"
    t.decimal "cost", precision: 8, scale: 2
    t.time "end_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end
end
