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

ActiveRecord::Schema.define(version: 2022_02_06_053724) do

  create_table "candidates", charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name"
    t.integer "list_position"
    t.bigint "recruitment_selection_id", null: false
    t.bigint "recruiter_id"
    t.bigint "channel_id"
    t.bigint "position_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["channel_id"], name: "index_candidates_on_channel_id"
    t.index ["position_id"], name: "index_candidates_on_position_id"
    t.index ["recruiter_id"], name: "index_candidates_on_recruiter_id"
    t.index ["recruitment_selection_id"], name: "index_candidates_on_recruitment_selection_id"
  end

  create_table "channels", charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name"
    t.integer "category"
    t.integer "automation", default: 10, null: false
    t.string "apply_token"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "organization_id"
    t.index ["organization_id"], name: "index_channels_on_organization_id"
  end

  create_table "organization_recruiters", charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "role"
    t.bigint "organization_id", null: false
    t.bigint "recruiter_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["organization_id"], name: "index_organization_recruiters_on_organization_id"
    t.index ["recruiter_id"], name: "index_organization_recruiters_on_recruiter_id"
  end

  create_table "organizations", charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name"
    t.string "unique_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["unique_id"], name: "index_organizations_on_unique_id", unique: true
  end

  create_table "positions", charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "internal_name"
    t.string "external_name"
    t.integer "status", default: 10
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "organization_id"
    t.index ["organization_id"], name: "index_positions_on_organization_id"
  end

  create_table "recruiter_invitations", charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "email"
    t.integer "role"
    t.string "token"
    t.datetime "expired_at"
    t.bigint "organization_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["organization_id"], name: "index_recruiter_invitations_on_organization_id"
    t.index ["token"], name: "index_recruiter_invitations_on_token", unique: true
  end

  create_table "recruiters", charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.boolean "allow_password_change", default: false
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "name"
    t.string "nickname"
    t.string "image"
    t.string "email"
    t.integer "level", default: 1
    t.text "tokens"
    t.string "google_access_token"
    t.string "google_refresh_token"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["confirmation_token"], name: "index_recruiters_on_confirmation_token", unique: true
    t.index ["email"], name: "index_recruiters_on_email", unique: true
    t.index ["reset_password_token"], name: "index_recruiters_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_recruiters_on_uid_and_provider", unique: true
  end

  create_table "recruitment_evaluations", charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.bigint "recruitment_history_id", null: false
    t.bigint "recruiter_id", null: false
    t.integer "result"
    t.datetime "input_at"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["recruiter_id"], name: "index_recruitment_evaluations_on_recruiter_id"
    t.index ["recruitment_history_id"], name: "index_recruitment_evaluations_on_recruitment_history_id"
  end

  create_table "recruitment_histories", charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.datetime "selected_at"
    t.integer "result"
    t.string "auto_scheduling_token"
    t.bigint "recruitment_selection_id", null: false
    t.bigint "candidate_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["auto_scheduling_token"], name: "index_recruitment_histories_on_auto_scheduling_token", unique: true
    t.index ["candidate_id"], name: "index_recruitment_histories_on_candidate_id"
    t.index ["recruitment_selection_id"], name: "index_recruitment_histories_on_recruitment_selection_id"
  end

  create_table "recruitment_projects", charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "organization_id"
    t.index ["organization_id"], name: "index_recruitment_projects_on_organization_id"
  end

  create_table "recruitment_selections", charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name"
    t.integer "selection_type"
    t.integer "position"
    t.bigint "recruitment_project_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["recruitment_project_id"], name: "index_recruitment_selections_on_recruitment_project_id"
  end

  add_foreign_key "candidates", "recruitment_selections"
  add_foreign_key "organization_recruiters", "organizations"
  add_foreign_key "organization_recruiters", "recruiters"
  add_foreign_key "recruiter_invitations", "organizations"
  add_foreign_key "recruitment_evaluations", "recruiters"
  add_foreign_key "recruitment_evaluations", "recruitment_histories"
  add_foreign_key "recruitment_histories", "candidates"
  add_foreign_key "recruitment_histories", "recruitment_selections"
  add_foreign_key "recruitment_selections", "recruitment_projects"
end
