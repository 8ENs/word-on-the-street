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

ActiveRecord::Schema.define(version: 20150520022050) do

  create_table "tracks", force: true do |t|
    t.string   "song"
    t.string   "album"
    t.string   "artist"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "url"
    t.integer  "user_id"
    t.integer  "likes",      default: 0
  end

  add_index "tracks", ["user_id"], name: "index_tracks_on_user_id"

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password"
  end

  create_table "votes", force: true do |t|
    t.integer  "track_id"
    t.integer  "user_id"
    t.integer  "vote",       default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "votes", ["track_id"], name: "index_votes_on_track_id"
  add_index "votes", ["user_id"], name: "index_votes_on_user_id"

end
