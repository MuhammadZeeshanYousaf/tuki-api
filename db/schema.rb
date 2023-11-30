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

ActiveRecord::Schema[7.1].define(version: 2023_11_30_160733) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "announcements", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.text "content"
    t.uuid "user_id", null: false, comment: "The User of role Admin or Super Admin, or could be Owner who has access to."
    t.uuid "announced_to", comment: "If a specific user is announced_to then reference of that user."
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "topic"
    t.integer "group", default: 0, comment: "An enum, it could be warning or alert."
    t.index ["user_id"], name: "index_announcements_on_user_id"
  end

  create_table "apartments", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "number"
    t.string "license_plate"
    t.uuid "community_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["community_id"], name: "index_apartments_on_community_id"
  end

  create_table "assignments", force: :cascade do |t|
    t.uuid "user_id", null: false
    t.uuid "role_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["role_id"], name: "index_assignments_on_role_id"
    t.index ["user_id"], name: "index_assignments_on_user_id"
  end

  create_table "bookings", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "bookable_type", null: false
    t.uuid "bookable_id", null: false
    t.uuid "booked_by_id", null: false, comment: "Custom column name which references to users table."
    t.float "amount_paid", comment: "How much the amount deducted from user account for the booking."
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bookable_type", "bookable_id"], name: "index_bookings_on_bookable"
    t.index ["booked_by_id"], name: "index_bookings_on_booked_by_id"
  end

  create_table "communities", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "eliminated_accounts", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "eliminated_type", null: false
    t.uuid "eliminated_id", null: false
    t.string "reason"
    t.text "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["eliminated_type", "eliminated_id"], name: "index_eliminated_accounts_on_eliminated"
  end

  create_table "events", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "community_id", null: false
    t.string "name"
    t.text "description"
    t.integer "seats", comment: "Available seats"
    t.datetime "start_time", comment: "When to start"
    t.datetime "end_time", comment: "When to end"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "start_date", comment: "Date on the event start and end."
    t.date "end_date", comment: "Date on the event start and end."
    t.index ["community_id"], name: "index_events_on_community_id"
  end

  create_table "guests", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id", null: false, comment: "A temporary member account will be created for guest."
    t.integer "type", default: 0, comment: "Guest can be a regular or working guest."
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_guests_on_user_id"
  end

  create_table "jwt_denylists", force: :cascade do |t|
    t.string "jti", null: false
    t.datetime "exp", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["jti"], name: "index_jwt_denylists_on_jti"
  end

  create_table "owners", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id", null: false
    t.uuid "apartment_id", null: false
    t.uuid "ownership_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["apartment_id"], name: "index_owners_on_apartment_id"
    t.index ["ownership_id"], name: "index_owners_on_ownership_id"
    t.index ["user_id"], name: "index_owners_on_user_id"
  end

  create_table "passes", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "event_id", null: false
    t.integer "valid_days", comment: "Pass validity days."
    t.float "price", comment: "Price of the pass, possibly in dollars."
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_passes_on_event_id"
  end

  create_table "quinchos", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "community_id", null: false
    t.string "name"
    t.text "description"
    t.boolean "is_grilled", default: false, comment: "Some Barbecue areas (Quinchos) have grills, others don't"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["community_id"], name: "index_quinchos_on_community_id"
  end

  create_table "reservations", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "reservable_type", null: false
    t.uuid "reservable_id", null: false
    t.integer "reserved_hours", comment: "Number of hours for an amenity is reserved. ( No more than 24)"
    t.float "rent_paid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["reservable_type", "reservable_id"], name: "index_reservations_on_reservable"
  end

  create_table "roles", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.integer "key", default: 0
    t.string "updated_at"
    t.string "created_at"
    t.index ["key"], name: "index_roles_on_key", unique: true
  end

  create_table "sport_courts", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "community_id", null: false
    t.string "name"
    t.string "sport", comment: "Sport / Game name which is offered in the sport_court."
    t.float "rent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["community_id"], name: "index_sport_courts_on_community_id"
  end

  create_table "tenants", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id", null: false
    t.uuid "owner_id", null: false
    t.uuid "tenantship_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_id"], name: "index_tenants_on_owner_id"
    t.index ["tenantship_id"], name: "index_tenants_on_tenantship_id"
    t.index ["user_id"], name: "index_tenants_on_user_id"
  end

  create_table "tickets", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "event_id", null: false
    t.text "description"
    t.float "price", comment: "Price could be in dollars."
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_tickets_on_event_id"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "contact"
    t.string "national_id"
    t.date "birthdate"
    t.uuid "community_id"
    t.index ["community_id"], name: "index_users_on_community_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["national_id"], name: "index_users_on_national_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "validations", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "booking_id", null: false
    t.uuid "validated_by_id", null: false
    t.integer "status", default: 0, comment: "e.g., Is it valid or not."
    t.text "note", comment: "If someone misbehaves or for any reason, the note will be recorded."
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["booking_id"], name: "index_validations_on_booking_id"
    t.index ["validated_by_id"], name: "index_validations_on_validated_by_id"
  end

  add_foreign_key "announcements", "users"
  add_foreign_key "apartments", "communities"
  add_foreign_key "assignments", "roles"
  add_foreign_key "assignments", "users"
  add_foreign_key "bookings", "users", column: "booked_by_id"
  add_foreign_key "events", "communities"
  add_foreign_key "guests", "users"
  add_foreign_key "owners", "apartments"
  add_foreign_key "owners", "owners", column: "ownership_id"
  add_foreign_key "owners", "users"
  add_foreign_key "passes", "events"
  add_foreign_key "quinchos", "communities"
  add_foreign_key "sport_courts", "communities"
  add_foreign_key "tenants", "owners"
  add_foreign_key "tenants", "tenants", column: "tenantship_id"
  add_foreign_key "tenants", "users"
  add_foreign_key "tickets", "events"
  add_foreign_key "validations", "bookings"
  add_foreign_key "validations", "users", column: "validated_by_id"
end
