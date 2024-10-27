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

ActiveRecord::Schema[7.1].define(version: 2024_10_27_051525) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource"
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "appointments", force: :cascade do |t|
    t.integer "patient_id"
    t.text "problem"
    t.integer "doctor_id"
    t.string "appointment_status"
    t.datetime "appointment_timing"
    t.decimal "consultancy_fees"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "appointment_type"
    t.integer "ward_id"
    t.integer "bed_id"
    t.string "hospital_registration_id"
  end

  create_table "beds", force: :cascade do |t|
    t.string "bed_number"
    t.string "bed_type"
    t.string "status"
    t.datetime "entryDate"
    t.datetime "exitDate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "ward_id"
    t.decimal "cost_per_day"
  end

  create_table "doctors", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.bigint "phone_number"
    t.string "role"
    t.string "email"
    t.string "password_digest"
    t.string "plaintext_password"
    t.string "specialist_in"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "profile"
    t.integer "hospital_registration_id"
    t.datetime "deleted_at"
    t.string "status"
  end

  create_table "hospital_registrations", force: :cascade do |t|
    t.string "hos_name"
    t.string "email"
    t.string "password_digest"
    t.string "location"
    t.string "plaintext_password"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "role"
    t.bigint "phone_number"
  end

  create_table "nurses", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.bigint "phone_number"
    t.string "email"
    t.string "hospital_registration_id"
    t.text "profile"
    t.string "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.string "status"
  end

  create_table "patients", force: :cascade do |t|
    t.string "name"
    t.string "gender"
    t.string "occupation"
    t.string "email"
    t.string "address"
    t.bigint "phone_number"
    t.string "role"
    t.string "hospital_registration_id"
    t.string "paymentstatus"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "age"
  end

  create_table "payments", force: :cascade do |t|
    t.integer "patient_id"
    t.integer "appointment_id"
    t.decimal "total_amount"
    t.string "payment_status"
    t.decimal "due_amount"
    t.decimal "paid_amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "payment_mode"
  end

  create_table "receptionists", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.bigint "phone_number"
    t.string "role"
    t.string "email"
    t.string "password_digest"
    t.string "plaintext_password"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "hospital_registration_id"
    t.text "profile"
    t.datetime "deleted_at"
    t.string "status"
  end

  create_table "wards", force: :cascade do |t|
    t.integer "available_beds"
    t.string "ward_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "hospital_registration_id"
    t.string "ward_name"
  end

end
