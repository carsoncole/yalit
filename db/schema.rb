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

ActiveRecord::Schema.define(version: 2019_12_10_193753) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "chapters", force: :cascade do |t|
    t.bigint "project_id", null: false
    t.string "title"
    t.text "content"
    t.integer "rank"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["project_id"], name: "index_chapters_on_project_id"
  end

  create_table "error_codes", force: :cascade do |t|
    t.bigint "section_id", null: false
    t.string "title"
    t.integer "http_status_code"
    t.integer "custom_status_code"
    t.string "message"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["section_id"], name: "index_error_codes_on_section_id"
  end

  create_table "invitations", force: :cascade do |t|
    t.bigint "project_id", null: false
    t.string "email"
    t.string "role"
    t.integer "invited_by_user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["project_id"], name: "index_invitations_on_project_id"
  end

  create_table "parameters", force: :cascade do |t|
    t.bigint "request_method_id", null: false
    t.string "name"
    t.string "description"
    t.string "type", default: "integer"
    t.boolean "is_required", default: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["request_method_id"], name: "index_parameters_on_request_method_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "host_name"
    t.string "ssl_endpoint_domain"
    t.string "color"
    t.string "description"
    t.string "terms_of_service_url"
    t.string "contact_name"
    t.string "contact_url"
    t.string "contact_email"
    t.string "license_name"
    t.string "license_url"
    t.string "version"
    t.boolean "is_published", default: false
    t.string "heroku_acm_status"
    t.string "heroku_acm_status_reason"
    t.string "heroku_cname"
    t.datetime "heroku_acm_created_at"
    t.string "heroku_acm_id"
    t.string "heroku_domain_status"
    t.datetime "heroku_acm_updated_at"
    t.boolean "is_hosted", default: false
    t.string "root_url"
    t.string "open_api_version"
  end

  create_table "request_methods", force: :cascade do |t|
    t.bigint "section_id", null: false
    t.string "verb"
    t.string "title"
    t.string "path"
    t.text "request_content"
    t.text "response_content"
    t.integer "rank"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "project_id"
    t.string "description"
    t.integer "response_code"
    t.text "response_body"
    t.index ["section_id"], name: "index_request_methods_on_section_id"
  end

  create_table "sections", force: :cascade do |t|
    t.bigint "chapter_id", null: false
    t.string "title"
    t.text "content"
    t.integer "rank"
    t.boolean "is_resource", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "is_error_codes", default: false
    t.string "error_endpoint_path"
    t.index ["chapter_id"], name: "index_sections_on_chapter_id"
  end

  create_table "servers", force: :cascade do |t|
    t.bigint "project_id", null: false
    t.string "url"
    t.string "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "use_for_ping", default: false
    t.string "authorization_header"
    t.string "content_type_header", default: "application/json"
    t.index ["project_id"], name: "index_servers_on_project_id"
  end

  create_table "sub_sections", force: :cascade do |t|
    t.bigint "section_id", null: false
    t.string "title"
    t.text "content"
    t.integer "rank"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["section_id"], name: "index_sub_sections_on_section_id"
  end

  create_table "user_projects", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "project_id", null: false
    t.string "role", default: "owner"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["project_id"], name: "index_user_projects_on_project_id"
    t.index ["user_id"], name: "index_user_projects_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "email", null: false
    t.string "encrypted_password", limit: 128, null: false
    t.string "confirmation_token", limit: 128
    t.string "remember_token", limit: 128, null: false
    t.boolean "is_beta_user", default: false
    t.index ["email"], name: "index_users_on_email"
    t.index ["remember_token"], name: "index_users_on_remember_token"
  end

  add_foreign_key "chapters", "projects"
  add_foreign_key "error_codes", "sections"
  add_foreign_key "invitations", "projects"
  add_foreign_key "parameters", "request_methods"
  add_foreign_key "request_methods", "sections"
  add_foreign_key "sections", "chapters"
  add_foreign_key "servers", "projects"
  add_foreign_key "sub_sections", "sections"
  add_foreign_key "user_projects", "projects"
  add_foreign_key "user_projects", "users"
end
