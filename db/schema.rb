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

ActiveRecord::Schema.define(version: 20160228015922) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clip_categories", force: :cascade do |t|
    t.string "name"
  end

  create_table "countries", force: :cascade do |t|
    t.string "name"
  end

  create_table "clubs", force: :cascade do |t|
    t.string   "name"
    t.integer  "country_id", index: {name: "index_clubs_on_country_id"}, foreign_key: {references: "countries", name: "fk_rails_38ad3459ad", on_update: :no_action, on_delete: :no_action}
    t.boolean  "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false, index: {name: "index_users_on_email", unique: true}
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token",   index: {name: "index_users_on_reset_password_token", unique: true}
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "role_id",                index: {name: "index_users_on_role_id"}, foreign_key: {references: "roles", name: "fk_rails_642f17018b", on_update: :no_action, on_delete: :no_action}
    t.integer  "club_id",                index: {name: "index_users_on_club_id"}, foreign_key: {references: "clubs", name: "fk_users_club_id", on_update: :no_action, on_delete: :no_action}
  end

  create_table "match_categories", force: :cascade do |t|
    t.string "name"
  end

  create_table "matches", force: :cascade do |t|
    t.integer  "club_id",     index: {name: "index_matches_on_club_id"}, foreign_key: {references: "clubs", name: "fk_matches_club_id", on_update: :no_action, on_delete: :no_action}
    t.integer  "category_id", index: {name: "index_matches_on_category_id"}, foreign_key: {references: "match_categories", name: "fk_matches_category_id", on_update: :no_action, on_delete: :no_action}
    t.string   "name"
    t.date     "date"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "videos", force: :cascade do |t|
    t.integer  "match_id",      index: {name: "index_videos_on_match_id"}, foreign_key: {references: "matches", name: "fk_videos_match_id", on_update: :no_action, on_delete: :no_action}
    t.string   "url"
    t.string   "ytv_id"
    t.string   "title"
    t.integer  "duration"
    t.string   "thumbnail_url"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "clips", force: :cascade do |t|
    t.integer  "video_id",    index: {name: "index_clips_on_video_id"}, foreign_key: {references: "videos", name: "fk_clips_video_id", on_update: :no_action, on_delete: :no_action}
    t.integer  "category_id", index: {name: "index_clips_on_category_id"}, foreign_key: {references: "clip_categories", name: "fk_clips_category_id", on_update: :no_action, on_delete: :no_action}
    t.string   "name"
    t.integer  "start"
    t.integer  "end"
    t.integer  "player_id",   index: {name: "index_clips_on_player_id"}, foreign_key: {references: "users", name: "fk_clips_player_id", on_update: :no_action, on_delete: :no_action}
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "clip_players", force: :cascade do |t|
    t.integer  "clip_id",      index: {name: "index_clip_players_on_clip_id"}, foreign_key: {references: "clips", name: "fk_clip_players_clip_id", on_update: :no_action, on_delete: :no_action}
    t.integer  "player_id",    index: {name: "index_clip_players_on_player_id"}, foreign_key: {references: "users", name: "fk_clip_players_player_id", on_update: :no_action, on_delete: :no_action}
    t.datetime "last_watched"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "clip_questions", force: :cascade do |t|
    t.integer  "clip_id",    index: {name: "index_clip_questions_on_clip_id"}, foreign_key: {references: "clips", name: "fk_clip_questions_clip_id", on_update: :no_action, on_delete: :no_action}
    t.text     "question"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "match_stats", force: :cascade do |t|
    t.integer "match_id",       index: {name: "index_match_stats_on_match_id"}, foreign_key: {references: "matches", name: "fk_match_stats_match_id", on_update: :no_action, on_delete: :no_action}
    t.integer "shots_on_goals"
    t.integer "corners"
    t.integer "goals"
  end

  create_table "playlists", force: :cascade do |t|
    t.integer "club_id", index: {name: "index_playlists_on_club_id"}, foreign_key: {references: "clubs", name: "fk_playlists_club_id", on_update: :no_action, on_delete: :no_action}
    t.string  "name"
  end

  create_table "playlist_clips", force: :cascade do |t|
    t.integer "playlist_id", index: {name: "index_playlist_clips_on_playlist_id"}, foreign_key: {references: "playlists", name: "fk_playlist_clips_playlist_id", on_update: :no_action, on_delete: :no_action}
    t.integer "clip_id",     index: {name: "index_playlist_clips_on_clip_id"}, foreign_key: {references: "clips", name: "fk_playlist_clips_clip_id", on_update: :no_action, on_delete: :no_action}
  end

  create_table "playlist_questions", force: :cascade do |t|
    t.integer  "playlist_id", index: {name: "index_playlist_questions_on_playlist_id"}, foreign_key: {references: "playlists", name: "fk_playlist_questions_playlist_id", on_update: :no_action, on_delete: :no_action}
    t.text     "question"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "profiles", force: :cascade do |t|
    t.integer  "user_id",             index: {name: "index_profiles_on_user_id"}, foreign_key: {references: "users", name: "fk_rails_e424190865", on_update: :no_action, on_delete: :no_action}
    t.string   "full_name"
    t.date     "birthday"
    t.string   "gender"
    t.text     "introduction"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  create_table "video_questions", force: :cascade do |t|
    t.integer  "video_id",   index: {name: "index_video_questions_on_video_id"}, foreign_key: {references: "videos", name: "fk_video_questions_video_id", on_update: :no_action, on_delete: :no_action}
    t.text     "question"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
