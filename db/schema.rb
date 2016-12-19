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

ActiveRecord::Schema.define(version: 20161110182209) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bootsy_image_galleries", force: :cascade do |t|
    t.string   "bootsy_resource_type"
    t.integer  "bootsy_resource_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bootsy_images", force: :cascade do |t|
    t.string   "image_file"
    t.integer  "image_gallery_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "course_tags", force: :cascade do |t|
    t.string   "word"
    t.integer  "course_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "courses", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "pages", force: :cascade do |t|
    t.string   "name",       null: false
    t.string   "path",       null: false
    t.string   "title",      null: false
    t.text     "html"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_pages_on_name", using: :btree
  end

  create_table "people", force: :cascade do |t|
    t.string   "linkedin"
    t.string   "google_plus"
    t.string   "scopus"
    t.string   "university",     default: "itmo", null: false
    t.string   "awards"
    t.string   "impact_story"
    t.string   "google_scholar"
    t.string   "cv"
    t.string   "orcid"
    t.string   "name",                            null: false
    t.text     "biography"
    t.string   "email"
    t.string   "room"
    t.string   "laboratory"
    t.string   "website"
    t.string   "github"
    t.string   "education"
    t.string   "twitter"
    t.string   "photo"
    t.string   "fb"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.index ["name"], name: "index_people_on_name", using: :btree
  end

  create_table "people_projects", id: false, force: :cascade do |t|
    t.integer "person_id"
    t.integer "project_id"
    t.index ["person_id", "project_id"], name: "index_people_projects_on_person_id_and_project_id", using: :btree
  end

  create_table "people_publications", id: false, force: :cascade do |t|
    t.integer "person_id"
    t.integer "publication_id"
    t.index ["person_id", "publication_id"], name: "index_people_publications_on_person_id_and_publication_id", using: :btree
  end

  create_table "projects", force: :cascade do |t|
    t.string   "github"
    t.string   "twitter"
    t.string   "keywords"
    t.boolean  "status"
    t.string   "title"
    t.string   "name"
    t.string   "logo"
    t.date     "start_date"
    t.date     "end_date"
    t.text     "full_description"
    t.string   "link"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.text     "short_description"
  end

  create_table "projects_publications", id: false, force: :cascade do |t|
    t.integer "project_id"
    t.integer "publication_id"
  end

  create_table "publications", force: :cascade do |t|
    t.string   "bib",        null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "research_areas", force: :cascade do |t|
    t.string   "uri"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["uri"], name: "research_areas_dimensions", unique: true, using: :btree
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.string   "resource_type"
    t.integer  "resource_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
    t.index ["name"], name: "index_roles_on_name", using: :btree
  end

  create_table "users", force: :cascade do |t|
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
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree
  end

end
