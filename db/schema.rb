# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090611143741) do

  create_table "mentorship_skills", :force => true do |t|
    t.integer  "mentorship_id"
    t.integer  "skill_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mentorships", :force => true do |t|
    t.integer  "mentee_id"
    t.integer  "mentor_id"
    t.integer  "sender_id"
    t.integer  "receiver_id"
    t.datetime "accepted_at"
    t.datetime "rejected_at"
    t.datetime "completed_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "sender_note"
    t.text     "receiver_note"
  end

  create_table "skills", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_skills", :force => true do |t|
    t.integer  "user_id"
    t.integer  "skill_id"
    t.integer  "level"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.text     "master_skills"
    t.text     "intermediate_skills"
    t.text     "newbie_skills"
    t.string   "remote_availability"
    t.string   "local_availability"
    t.boolean  "available_to_mentor"
    t.boolean  "available_to_be_mentored"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "login",                     :limit => 40
    t.string   "email",                     :limit => 100
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.string   "remember_token",            :limit => 40
    t.datetime "remember_token_expires_at"
  end

  add_index "users", ["login"], :name => "index_users_on_login", :unique => true

end
