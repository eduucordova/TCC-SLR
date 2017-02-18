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

ActiveRecord::Schema.define(version: 20170218192901) do

  create_table "acms", force: :cascade do |t|
    t.text     "abstract",       limit: 65535
    t.string   "author",         limit: 255
    t.string   "generic_string", limit: 255
    t.string   "link",           limit: 255
    t.string   "publisher",      limit: 255
    t.string   "pubtitle",       limit: 255
    t.string   "pubtype",        limit: 255
    t.string   "title",          limit: 255
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.boolean  "included",       limit: 1
    t.boolean  "selected",       limit: 1
    t.integer  "protocol_id",    limit: 4
    t.text     "year",           limit: 65535
  end

  create_table "acms_users_protocols", force: :cascade do |t|
    t.integer "acm_id",            limit: 4
    t.integer "users_protocol_id", limit: 4
    t.boolean "included",          limit: 1
    t.boolean "pre_selected",      limit: 1
  end

  add_index "acms_users_protocols", ["acm_id"], name: "index_acms_users_protocols_on_acm_id", using: :btree
  add_index "acms_users_protocols", ["users_protocol_id"], name: "index_acms_users_protocols_on_users_protocol_id", using: :btree

  create_table "google_scholars", force: :cascade do |t|
    t.text     "abstract",    limit: 65535
    t.string   "author",      limit: 255
    t.string   "link",        limit: 255
    t.string   "publisher",   limit: 255
    t.string   "pubtitle",    limit: 255
    t.string   "pubtype",     limit: 255
    t.string   "title",       limit: 255
    t.integer  "protocol_id", limit: 4
    t.boolean  "included",    limit: 1
    t.boolean  "selected",    limit: 1
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "ieees", force: :cascade do |t|
    t.string   "title",          limit: 255
    t.string   "author",         limit: 255
    t.text     "abstract",       limit: 65535
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "generic_string", limit: 255
    t.string   "pubtype",        limit: 255
    t.string   "pubtitle",       limit: 255
    t.string   "link",           limit: 255
    t.string   "publisher",      limit: 255
    t.boolean  "included",       limit: 1
    t.integer  "protocol_id",    limit: 4
    t.boolean  "selected",       limit: 1
    t.integer  "year",           limit: 4
  end

  create_table "ieees_users_protocols", force: :cascade do |t|
    t.integer "ieee_id",           limit: 4
    t.integer "users_protocol_id", limit: 4
    t.boolean "included",          limit: 1
    t.boolean "pre_selected",      limit: 1
  end

  add_index "ieees_users_protocols", ["ieee_id"], name: "index_ieees_users_protocols_on_ieee_id", using: :btree
  add_index "ieees_users_protocols", ["users_protocol_id"], name: "index_ieees_users_protocols_on_users_protocol_id", using: :btree

  create_table "includeds", force: :cascade do |t|
    t.string   "title",         limit: 255
    t.string   "author",        limit: 255
    t.string   "pubtitle",      limit: 255
    t.boolean  "included",      limit: 1
    t.integer  "protocol_id",   limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "link",          limit: 255
    t.string   "name_database", limit: 255
  end

  create_table "protocols", force: :cascade do |t|
    t.string   "title",             limit: 255
    t.string   "author",            limit: 255
    t.text     "background",        limit: 65535
    t.string   "research_question", limit: 255
    t.text     "strategy",          limit: 65535
    t.text     "criteria",          limit: 65535
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.text     "query",             limit: 65535
    t.integer  "from",              limit: 4
    t.integer  "to",                limit: 4
    t.boolean  "ieee",              limit: 1
    t.boolean  "acm",               limit: 1
    t.boolean  "springer",          limit: 1
    t.boolean  "science_direct",    limit: 1
    t.boolean  "google_scholar",    limit: 1
    t.string   "quality",           limit: 255
    t.boolean  "scopus",            limit: 1
    t.integer  "results_returned",  limit: 4
  end

  create_table "references", force: :cascade do |t|
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "database_name", limit: 255
    t.string   "results",       limit: 255
    t.string   "protocol_id",   limit: 255
    t.string   "database",      limit: 255
    t.integer  "total_found",   limit: 4
  end

  add_index "references", ["protocol_id"], name: "index_references_on_protocol_id", using: :btree

  create_table "roles", force: :cascade do |t|
    t.string "name", limit: 255
  end

  create_table "scidirs", force: :cascade do |t|
    t.text     "abstract",       limit: 65535
    t.string   "author",         limit: 255
    t.string   "generic_string", limit: 255
    t.string   "link",           limit: 255
    t.string   "publisher",      limit: 255
    t.string   "pubtitle",       limit: 255
    t.string   "pubtype",        limit: 255
    t.string   "title",          limit: 255
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "protocol_id",    limit: 4
    t.boolean  "included",       limit: 1
    t.boolean  "selected",       limit: 1
    t.integer  "year",           limit: 4
  end

  create_table "scidirs_users_protocols", force: :cascade do |t|
    t.integer "scidir_id",         limit: 4
    t.integer "users_protocol_id", limit: 4
    t.boolean "included",          limit: 1
    t.boolean "pre_selected",      limit: 1
  end

  add_index "scidirs_users_protocols", ["scidir_id"], name: "index_scidirs_users_protocols_on_scidir_id", using: :btree
  add_index "scidirs_users_protocols", ["users_protocol_id"], name: "index_scidirs_users_protocols_on_users_protocol_id", using: :btree

  create_table "scopus", force: :cascade do |t|
    t.text     "abstract",            limit: 65535
    t.string   "author",              limit: 255
    t.string   "link",                limit: 255
    t.string   "publisher",           limit: 255
    t.string   "pubtitle",            limit: 255
    t.string   "pubtype",             limit: 255
    t.string   "title",               limit: 255
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.boolean  "included",            limit: 1
    t.boolean  "selected",            limit: 1
    t.string   "protocol_id_integer", limit: 255
    t.integer  "protocol_id",         limit: 4
    t.integer  "year",                limit: 4
  end

  create_table "scopus_users_protocols", force: :cascade do |t|
    t.integer "scopu_id",          limit: 4
    t.integer "users_protocol_id", limit: 4
    t.boolean "included",          limit: 1
    t.boolean "pre_selected",      limit: 1
  end

  add_index "scopus_users_protocols", ["scopu_id"], name: "index_scopus_users_protocols_on_scopu_id", using: :btree
  add_index "scopus_users_protocols", ["users_protocol_id"], name: "index_scopus_users_protocols_on_users_protocol_id", using: :btree

  create_table "springers", force: :cascade do |t|
    t.text     "abstract",    limit: 65535
    t.string   "author",      limit: 255
    t.string   "link",        limit: 255
    t.string   "publisher",   limit: 255
    t.string   "pubtitle",    limit: 255
    t.string   "pubtype",     limit: 255
    t.string   "title",       limit: 255
    t.integer  "protocol_id", limit: 4
    t.boolean  "included",    limit: 1
    t.boolean  "selected",    limit: 1
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "year",        limit: 4
  end

  create_table "springers_users_protocols", force: :cascade do |t|
    t.integer "springer_id",       limit: 4
    t.integer "users_protocol_id", limit: 4
    t.boolean "included",          limit: 1
    t.boolean "pre_selected",      limit: 1
  end

  add_index "springers_users_protocols", ["springer_id"], name: "index_springers_users_protocols_on_springer_id", using: :btree
  add_index "springers_users_protocols", ["users_protocol_id"], name: "index_springers_users_protocols_on_users_protocol_id", using: :btree

  create_table "terms", force: :cascade do |t|
    t.string   "termo",       limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "protocol_id", limit: 4
    t.string   "sinonimo",    limit: 255
    t.string   "traducao",    limit: 255
    t.string   "sinonimo2",   limit: 255
    t.string   "sinonimo3",   limit: 255
    t.string   "traducao2",   limit: 255
    t.string   "traducao3",   limit: 255
  end

  add_index "terms", ["protocol_id"], name: "index_terms_on_protocol_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "first_name",             limit: 255
    t.string   "last_name",              limit: 255
    t.string   "lab",                    limit: 255
    t.string   "username",               limit: 255
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

  create_table "users_protocols", force: :cascade do |t|
    t.integer  "user_id",     limit: 4
    t.integer  "protocol_id", limit: 4
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.integer  "role_id",     limit: 4
  end

  add_index "users_protocols", ["protocol_id"], name: "index_users_protocols_on_protocol_id", using: :btree
  add_index "users_protocols", ["role_id"], name: "index_users_protocols_on_role_id", using: :btree
  add_index "users_protocols", ["user_id"], name: "index_users_protocols_on_user_id", using: :btree

  add_foreign_key "acms_users_protocols", "acms", on_delete: :cascade
  add_foreign_key "acms_users_protocols", "users_protocols", on_delete: :cascade
  add_foreign_key "ieees_users_protocols", "ieees", on_delete: :cascade
  add_foreign_key "ieees_users_protocols", "users_protocols", on_delete: :cascade
  add_foreign_key "scidirs_users_protocols", "scidirs", on_delete: :cascade
  add_foreign_key "scidirs_users_protocols", "users_protocols", on_delete: :cascade
  add_foreign_key "scopus_users_protocols", "scopus", on_delete: :cascade
  add_foreign_key "scopus_users_protocols", "users_protocols", on_delete: :cascade
  add_foreign_key "springers_users_protocols", "springers", on_delete: :cascade
  add_foreign_key "springers_users_protocols", "users_protocols", on_delete: :cascade
  add_foreign_key "users_protocols", "protocols"
  add_foreign_key "users_protocols", "roles"
  add_foreign_key "users_protocols", "users"
end
