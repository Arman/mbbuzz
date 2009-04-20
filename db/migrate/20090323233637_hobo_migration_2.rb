class HoboMigration2 < ActiveRecord::Migration
  def self.up
    create_table :organization_assets do |t|
      t.string   :name
      t.boolean  :primary
      t.string   :content_type
      t.string   :filename
      t.integer  :size
      t.datetime :created_at
      t.datetime :updated_at
      t.integer  :organization_id
    end
    
    create_table :user_avatars do |t|
      t.string   :name
      t.boolean  :primary
      t.string   :content_type
      t.string   :filename
      t.integer  :size
      t.datetime :created_at
      t.datetime :updated_at
      t.integer  :user_id
    end
  end

  def self.down
    drop_table :organization_assets
    drop_table :user_avatars
  end
end
