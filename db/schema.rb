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

ActiveRecord::Schema[8.0].define(version: 2024_12_02_022433) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "comments", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "body"
    t.bigint "post_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_comments_on_post_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "likes", force: :cascade do |t|
    t.integer "liker_id", null: false
    t.integer "liked_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["liked_id"], name: "index_likes_on_liked_id"
    t.index ["liker_id", "liked_id"], name: "index_likes_on_liker_id_and_liked_id", unique: true
    t.index ["liker_id"], name: "index_likes_on_liker_id"
  end

  create_table "matches", force: :cascade do |t|
    t.bigint "user_1_id", null: false
    t.bigint "user_2_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_1_id", "user_2_id"], name: "index_matches_on_user_1_id_and_user_2_id", unique: true
    t.index ["user_1_id"], name: "index_matches_on_user_1_id"
    t.index ["user_2_id"], name: "index_matches_on_user_2_id"
  end

  create_table "messages", force: :cascade do |t|
    t.bigint "match_id", null: false
    t.bigint "user_id", null: false
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["match_id"], name: "index_messages_on_match_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "posts", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "title"
    t.string "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.boolean "admin", default: false, null: false
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "mobile_number", null: false
    t.date "birthdate", null: false
    t.string "gender", null: false
    t.string "sexual_orientation", null: false
    t.string "gender_interest", null: false
    t.string "country", null: false
    t.string "state", null: false
    t.string "city", null: false
    t.string "school"
    t.text "bio", null: false
    t.jsonb "images", default: [], null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "comments", "posts"
  add_foreign_key "comments", "users"
  add_foreign_key "matches", "users", column: "user_1_id"
  add_foreign_key "matches", "users", column: "user_2_id"
  add_foreign_key "messages", "matches"
  add_foreign_key "messages", "users"
  add_foreign_key "posts", "users"
end
