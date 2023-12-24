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

ActiveRecord::Schema[7.1].define(version: 2023_12_24_085447) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "active_storage_attachments", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.uuid "record_id", null: false
    t.uuid "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

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
    t.string "building_name"
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

  create_table "attendees", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "booking_id", null: false
    t.uuid "user_id", null: false
    t.index ["booking_id"], name: "index_attendees_on_booking_id"
    t.index ["user_id"], name: "index_attendees_on_user_id"
  end

  create_table "bookings", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "booker_id", null: false, comment: "Custom column name which references to users table."
    t.float "amount_paid", comment: "How much the amount deducted from user account for the booking."
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "total_attendees", comment: "Total attendees of the event including booker."
    t.integer "payment_status", default: 0, comment: "Enum of payment status."
    t.string "transaction_id", comment: "Transaction id from webpay."
    t.string "order_id", comment: "Order id from webpay."
    t.uuid "time_slot_id", null: false
    t.index ["booker_id"], name: "index_bookings_on_booker_id"
    t.index ["time_slot_id"], name: "index_bookings_on_time_slot_id"
    t.index ["transaction_id"], name: "index_bookings_on_transaction_id", unique: true
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "start_date", comment: "Date on the event start and end."
    t.date "end_date", comment: "Date on the event start and end."
    t.integer "event_type", default: 0
    t.float "charges", default: 0.0
    t.uuid "allocated_guard_id", comment: "Event can have an allocated guard."
    t.index ["allocated_guard_id"], name: "index_events_on_allocated_guard_id"
    t.index ["community_id"], name: "index_events_on_community_id"
  end

  create_table "guests", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id", null: false, comment: "A temporary member account will be created for guest."
    t.string "type", comment: "Guest can be a regular or working guest."
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "invited_by_id", null: false
    t.uuid "approved_by_id"
    t.datetime "valid_from", comment: "The Guest is valid from this Date and Time."
    t.datetime "valid_to", comment: "The Guest is valid till this Date and Time."
    t.index ["approved_by_id"], name: "index_guests_on_approved_by_id"
    t.index ["invited_by_id"], name: "index_guests_on_invited_by_id"
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

  create_table "time_slots", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "event_id", null: false
    t.integer "day", default: 0
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "available_seats"
    t.index ["event_id"], name: "index_time_slots_on_event_id"
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
    t.string "nationality"
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

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "announcements", "users"
  add_foreign_key "apartments", "communities"
  add_foreign_key "assignments", "roles"
  add_foreign_key "assignments", "users"
  add_foreign_key "attendees", "bookings"
  add_foreign_key "attendees", "users"
  add_foreign_key "bookings", "time_slots"
  add_foreign_key "bookings", "users", column: "booker_id"
  add_foreign_key "events", "communities"
  add_foreign_key "guests", "users"
  add_foreign_key "guests", "users", column: "approved_by_id"
  add_foreign_key "guests", "users", column: "invited_by_id"
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
  add_foreign_key "time_slots", "events"
  add_foreign_key "validations", "bookings"
  add_foreign_key "validations", "users", column: "validated_by_id"
end
