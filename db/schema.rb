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

ActiveRecord::Schema.define(version: 20160406013456) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: :cascade do |t|
    t.integer  "trackable_id",   index: {name: "index_activities_on_trackable_id_and_trackable_type", with: ["trackable_type"]}
    t.string   "trackable_type", index: {name: "fk__activities_trackable_id", with: ["trackable_id"]}
    t.integer  "owner_id",       index: {name: "index_activities_on_owner_id_and_owner_type", with: ["owner_type"]}
    t.string   "owner_type",     index: {name: "fk__activities_owner_id", with: ["owner_id"]}
    t.string   "key"
    t.text     "parameters"
    t.integer  "recipient_id",   index: {name: "index_activities_on_recipient_id_and_recipient_type", with: ["recipient_type"]}
    t.string   "recipient_type", index: {name: "fk__activities_recipient_id", with: ["recipient_id"]}
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "clip_categories", force: :cascade do |t|
    t.string "name", index: {name: "index_clip_categories_on_name", unique: true}
  end

  create_table "countries", force: :cascade do |t|
    t.string "name"
  end

  create_table "clubs", force: :cascade do |t|
    t.string   "name",       index: {name: "index_clubs_on_name_and_country_id", with: ["country_id"], unique: true}
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
    t.string "name", index: {name: "index_match_categories_on_name", unique: true}
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
    t.string   "url",           index: {name: "index_videos_on_url", unique: true}
    t.string   "ytv_id",        index: {name: "index_videos_on_ytv_id", unique: true}
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

  create_table "conversations", force: :cascade do |t|
    t.integer  "sender_id",    index: {name: "index_conversations_on_sender_id"}, foreign_key: {references: "users", name: "fk_conversations_sender_id", on_update: :no_action, on_delete: :no_action}
    t.integer  "recipient_id", index: {name: "index_conversations_on_recipient_id"}, foreign_key: {references: "users", name: "fk_conversations_recipient_id", on_update: :no_action, on_delete: :no_action}
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "match_stats", force: :cascade do |t|
    t.integer "match_id",           index: {name: "index_match_stats_on_match_id"}, foreign_key: {references: "matches", name: "fk_match_stats_match_id", on_update: :no_action, on_delete: :no_action}
    t.integer "goals_h"
    t.integer "goals_a"
    t.integer "total_shots_h"
    t.integer "total_shots_a"
    t.integer "shots_on_target_h"
    t.integer "shots_on_target_a"
    t.integer "completed_passes_h"
    t.integer "completed_passes_a"
    t.integer "passing_accuracy_h"
    t.integer "passing_accuracy_a"
    t.integer "possession_h"
    t.integer "corners_h"
    t.integer "corners_a"
    t.integer "offsides_h"
    t.integer "offsides_a"
    t.integer "fouls_conceded_h"
    t.integer "fouls_conceded_a"
  end

  create_table "messages", force: :cascade do |t|
    t.text     "body"
    t.integer  "conversation_id", index: {name: "fk__messages_conversation_id"}, foreign_key: {references: "conversations", name: "fk_messages_conversation_id", on_update: :no_action, on_delete: :no_action}
    t.integer  "user_id",         index: {name: "fk__messages_user_id"}, foreign_key: {references: "users", name: "fk_messages_user_id", on_update: :no_action, on_delete: :no_action}
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "playlists", force: :cascade do |t|
    t.integer "club_id", index: {name: "index_playlists_on_club_id"}, foreign_key: {references: "clubs", name: "fk_playlists_club_id", on_update: :no_action, on_delete: :no_action}
    t.string  "name"
  end
  add_index "playlists", ["club_id", "name"], name: "index_playlists_on_club_id_and_name", unique: true

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
