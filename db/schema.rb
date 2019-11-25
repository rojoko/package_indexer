# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_11_25_162842) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "contributors", force: :cascade do |t|
    t.string "name", null: false
    t.string "email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "unique_email", unique: true
  end

# Could not dump table "contributors_packages" because of following StandardError
#   Unknown type 'contributing_role' for column 'role'

  create_table "packages", force: :cascade do |t|
    t.string "name", null: false
    t.string "version", null: false
    t.string "title", null: false
    t.text "description"
    t.datetime "publication_date", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name", "version"], name: "unique_name_version", unique: true
    t.index ["name"], name: "index_packages_on_name"
    t.index ["publication_date"], name: "index_packages_on_publication_date"
    t.index ["version"], name: "index_packages_on_version"
  end

end
