class HoboMigration14 < ActiveRecord::Migration
  def self.up
    drop_table :organizations
    drop_table :category_organizations
  end

  def self.down
    create_table "organizations", :force => true do |t|
      t.string   "name"
      t.string   "address_line_1"
      t.string   "address_line_2"
      t.string   "city"
      t.string   "state_region"
      t.string   "country"
      t.string   "web_site"
      t.string   "phone"
      t.string   "fax"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.integer  "owner_id"
      t.string   "photo_file_name"
      t.string   "photo_content_type"
      t.integer  "photo_file_size"
      t.datetime "photo_updated_at"
      t.decimal  "avg_rating",         :precision => 3, :scale => 1, :default => 0.0
      t.text     "about"
      t.string   "zip_code"
    end
    
    create_table "category_organizations", :force => true do |t|
      t.datetime "created_at"
      t.datetime "updated_at"
      t.integer  "category_id"
      t.integer  "organization_id"
    end
  end
end
