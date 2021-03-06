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

ActiveRecord::Schema.define(:version => 20090624212213) do

  create_table "business_categories", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "category_id"
    t.integer  "business_id"
  end

  create_table "business_ownerships", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "business_id"
    t.boolean  "acknowledge"
    t.text     "notes"
    t.integer  "claimant_id"
    t.integer  "reviewer_id"
    t.integer  "owner_id"
    t.string   "state"
    t.datetime "key_timestamp"
  end

  create_table "businesses", :force => true do |t|
    t.string   "name"
    t.text     "about"
    t.string   "address_line_1"
    t.string   "address_line_2"
    t.string   "city"
    t.string   "zip_code"
    t.string   "state_region"
    t.string   "country",            :default => "US"
    t.string   "web_site"
    t.string   "phone"
    t.string   "fax"
    t.decimal  "avg_rating",         :default => 0.0
    t.decimal  "lat",                :default => 0.0
    t.decimal  "lng",                :default => 0.0
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "creator_id"
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "desc"
    t.text     "about"
    t.string   "icon"
  end

  create_table "employments", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "business_id"
    t.integer  "person_id"
    t.date     "start_date"
    t.date     "end_date"
  end

  create_table "folders", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "locations", :force => true do |t|
    t.string   "address_line_1"
    t.string   "address_line_2"
    t.string   "city"
    t.string   "zip_code"
    t.string   "state_region"
    t.string   "country"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "message_copies", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "message_id"
    t.integer  "recipient_id"
    t.integer  "folder_id"
  end

  create_table "messages", :force => true do |t|
    t.string   "subject"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "author_id"
  end

  create_table "pages", :force => true do |t|
    t.string   "name"
    t.string   "permalink"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "people", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.text     "bio"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "professional_title"
  end

  create_table "professional_profile_ownerships", :force => true do |t|
    t.boolean  "acknowledge"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "person_id"
    t.integer  "claimant_id"
    t.integer  "reviewer_id"
    t.integer  "owner_id"
    t.string   "state"
    t.datetime "key_timestamp"
  end

  create_table "reviews", :force => true do |t|
    t.integer  "rating"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "reviewer_id"
    t.integer  "business_id"
  end

  create_table "service_schedules", :force => true do |t|
    t.date     "start_date"
    t.time     "start_time"
    t.boolean  "recurring"
    t.string   "interval"
    t.integer  "frequency"
    t.decimal  "price"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "service_id"
  end

  create_table "services", :force => true do |t|
    t.string   "name"
    t.integer  "duration"
    t.decimal  "price",       :precision => 7, :scale => 2, :default => 0.0
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "business_id"
  end

  create_table "users", :force => true do |t|
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.string   "remember_token"
    t.datetime "remember_token_expires_at"
    t.string   "name"
    t.string   "email_address"
    t.boolean  "administrator",                           :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "state",                                   :default => "active"
    t.datetime "key_timestamp"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.text     "about_me"
    t.string   "first_name"
    t.string   "last_name"
  end

end
