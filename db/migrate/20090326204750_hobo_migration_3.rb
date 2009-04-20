class HoboMigration3 < ActiveRecord::Migration
  def self.up
    drop_table :organization_assets
  end

  def self.down
    create_table "organization_assets", :force => true do |t|
      t.string   "name"
      t.boolean  "primary"
      t.string   "content_type"
      t.string   "filename"
      t.integer  "size"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.integer  "organization_id"
    end
  end
end
