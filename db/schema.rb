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

ActiveRecord::Schema.define(version: 20141213090157) do

  create_table "attachments", force: true do |t|
    t.string   "description"
    t.string   "attachment"
    t.integer  "company_id"
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "certificates", force: true do |t|
    t.string   "description"
    t.datetime "cert_issue_date", null: false
    t.datetime "cert_eff_date",   null: false
    t.datetime "cert_term_date",  null: false
    t.integer  "user_id",         null: false
    t.integer  "company_id",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "companies", force: true do |t|
    t.string   "name"
    t.string   "address"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "national_proofs", force: true do |t|
    t.string   "national_id"
    t.string   "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.datetime "birth_date"
    t.datetime "issue_date"
    t.datetime "expiry_date"
    t.string   "gender"
    t.string   "nationality"
  end

  create_table "owners", force: true do |t|
    t.string   "name"
    t.string   "company_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "passport_attachment_file_name"
    t.string   "passport_attachment_content_type"
    t.integer  "passport_attachment_file_size"
    t.datetime "passport_attachment_updated_at"
    t.string   "national_attachment_file_name"
    t.string   "national_attachment_content_type"
    t.integer  "national_attachment_file_size"
    t.datetime "national_attachment_updated_at"
    t.string   "nationality"
    t.string   "phone"
    t.string   "email"
    t.string   "gender"
  end

  create_table "passport_proofs", force: true do |t|
    t.string   "passport_no"
    t.string   "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", force: true do |t|
    t.string "name"
  end

  create_table "user_roles", force: true do |t|
    t.integer  "user_id"
    t.integer  "role_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_roles", ["user_id", "role_id"], name: "index_user_roles_on_user_id_and_role_id", unique: true, using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
