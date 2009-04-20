class HoboMigration4 < ActiveRecord::Migration
  def self.up
    drop_table :user_avatars
  end

  def self.down
    create_table "user_avatars", :force => true do |t|
      t.string   "name"
      t.boolean  "primary"
      t.string   "content_type"
      t.string   "filename"
      t.integer  "size"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.integer  "user_id"
    end
  end
end
