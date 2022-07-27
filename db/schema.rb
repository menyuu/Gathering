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

ActiveRecord::Schema.define(version: 2022_07_27_135249) do

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.integer "record_id", null: false
    t.integer "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.integer "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "end_user_games", force: :cascade do |t|
    t.integer "end_user_id", null: false
    t.integer "game_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["end_user_id"], name: "index_end_user_games_on_end_user_id"
    t.index ["game_id"], name: "index_end_user_games_on_game_id"
  end

  create_table "end_user_genres", force: :cascade do |t|
    t.integer "end_user_id", null: false
    t.integer "genre_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["end_user_id"], name: "index_end_user_genres_on_end_user_id"
    t.index ["genre_id"], name: "index_end_user_genres_on_genre_id"
  end

  create_table "end_user_groups", force: :cascade do |t|
    t.integer "end_user_id", null: false
    t.integer "group_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["end_user_id"], name: "index_end_user_groups_on_end_user_id"
    t.index ["group_id"], name: "index_end_user_groups_on_group_id"
  end

  create_table "end_user_tags", force: :cascade do |t|
    t.integer "end_user_id", null: false
    t.integer "tag_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["end_user_id"], name: "index_end_user_tags_on_end_user_id"
    t.index ["tag_id"], name: "index_end_user_tags_on_tag_id"
  end

  create_table "end_users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.text "introduction", default: "", null: false
    t.integer "public_status", default: 0, null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_end_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_end_users_on_reset_password_token", unique: true
  end

  create_table "favorites", force: :cascade do |t|
    t.integer "end_user_id", null: false
    t.integer "post_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["end_user_id"], name: "index_favorites_on_end_user_id"
    t.index ["post_id"], name: "index_favorites_on_post_id"
  end

  create_table "games", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "genres", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "group_chats", force: :cascade do |t|
    t.integer "end_user_id", null: false
    t.integer "group_id", null: false
    t.text "chat", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["end_user_id"], name: "index_group_chats_on_end_user_id"
    t.index ["group_id"], name: "index_group_chats_on_group_id"
  end

  create_table "group_games", force: :cascade do |t|
    t.integer "group_id", null: false
    t.integer "genre_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["genre_id"], name: "index_group_games_on_genre_id"
    t.index ["group_id"], name: "index_group_games_on_group_id"
  end

  create_table "group_genres", force: :cascade do |t|
    t.integer "group_id", null: false
    t.integer "genre_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["genre_id"], name: "index_group_genres_on_genre_id"
    t.index ["group_id"], name: "index_group_genres_on_group_id"
  end

  create_table "group_tags", force: :cascade do |t|
    t.integer "group_id", null: false
    t.integer "tag_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["group_id"], name: "index_group_tags_on_group_id"
    t.index ["tag_id"], name: "index_group_tags_on_tag_id"
  end

  create_table "groups", force: :cascade do |t|
    t.integer "owner_id", null: false
    t.string "name", null: false
    t.text "introduction", default: "", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["owner_id"], name: "index_groups_on_owner_id"
  end

  create_table "post_comments", force: :cascade do |t|
    t.integer "end_user_id", null: false
    t.integer "post_id", null: false
    t.text "text", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["end_user_id"], name: "index_post_comments_on_end_user_id"
    t.index ["post_id"], name: "index_post_comments_on_post_id"
  end

  create_table "post_tags", force: :cascade do |t|
    t.integer "post_id", null: false
    t.integer "posting_tag_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["post_id"], name: "index_post_tags_on_post_id"
    t.index ["posting_tag_id"], name: "index_post_tags_on_posting_tag_id"
  end

  create_table "posting_tags", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "posts", force: :cascade do |t|
    t.integer "end_user_id", null: false
    t.text "text", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["end_user_id"], name: "index_posts_on_end_user_id"
  end

  create_table "relationships", force: :cascade do |t|
    t.integer "follower_id", null: false
    t.integer "followed_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["followed_id"], name: "index_relationships_on_followed_id"
    t.index ["follower_id"], name: "index_relationships_on_follower_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "end_user_games", "end_users"
  add_foreign_key "end_user_games", "games"
  add_foreign_key "end_user_genres", "end_users"
  add_foreign_key "end_user_genres", "genres"
  add_foreign_key "end_user_groups", "end_users"
  add_foreign_key "end_user_groups", "groups"
  add_foreign_key "end_user_tags", "end_users"
  add_foreign_key "end_user_tags", "tags"
  add_foreign_key "favorites", "end_users"
  add_foreign_key "favorites", "posts"
  add_foreign_key "group_chats", "end_users"
  add_foreign_key "group_chats", "groups"
  add_foreign_key "group_games", "genres"
  add_foreign_key "group_games", "groups"
  add_foreign_key "group_genres", "genres"
  add_foreign_key "group_genres", "groups"
  add_foreign_key "group_tags", "groups"
  add_foreign_key "group_tags", "tags"
  add_foreign_key "groups", "end_users", column: "owner_id"
  add_foreign_key "post_comments", "end_users"
  add_foreign_key "post_comments", "posts"
  add_foreign_key "post_tags", "posting_tags"
  add_foreign_key "post_tags", "posts"
  add_foreign_key "posts", "end_users"
  add_foreign_key "relationships", "end_users", column: "followed_id"
  add_foreign_key "relationships", "end_users", column: "follower_id"
end
