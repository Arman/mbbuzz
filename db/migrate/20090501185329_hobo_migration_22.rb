class HoboMigration22 < ActiveRecord::Migration
  def self.up
    create_table :folders do |t|
      t.string   :name
      t.datetime :created_at
      t.datetime :updated_at
      t.integer  :user_id
    end
    
    create_table :messages do |t|
      t.string   :subject
      t.text     :body
      t.datetime :created_at
      t.datetime :updated_at
      t.integer  :author_id
    end
    
    create_table :message_copies do |t|
      t.datetime :created_at
      t.datetime :updated_at
      t.integer  :message_id
      t.integer  :recipient_id
      t.integer  :folder_id
    end
    
    change_column :businesses, :lng, :decimal, :precision => 10, :default => 0, :scale => 7
    change_column :businesses, :lat, :decimal, :precision => 10, :default => 0, :scale => 7
    change_column :businesses, :avg_rating, :decimal, :precision => 3, :default => 0, :scale => 1
    
    add_column :people, :professional_title, :string
  end

  def self.down
    change_column :businesses, :lng, :decimal, :default => 0.0
    change_column :businesses, :lat, :decimal, :default => 0.0
    change_column :businesses, :avg_rating, :decimal, :default => 0.0
    
    remove_column :people, :professional_title
    
    drop_table :folders
    drop_table :messages
    drop_table :message_copies
  end
end
