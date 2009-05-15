class HoboMigration24 < ActiveRecord::Migration
  def self.up
    change_column :businesses, :lng, :decimal, :precision => 10, :default => 0, :scale => 7
    change_column :businesses, :lat, :decimal, :precision => 10, :default => 0, :scale => 7
    change_column :businesses, :avg_rating, :decimal, :precision => 3, :default => 0, :scale => 1
    
    add_column :business_ownerships, :acknowledge, :boolean
    add_column :business_ownerships, :notes, :text
    remove_column :business_ownerships, :requester_id
    remove_column :business_ownerships, :reviewer_id
  end

  def self.down
    change_column :businesses, :lng, :decimal, :default => 0.0
    change_column :businesses, :lat, :decimal, :default => 0.0
    change_column :businesses, :avg_rating, :decimal, :default => 0.0
    
    remove_column :business_ownerships, :acknowledge
    remove_column :business_ownerships, :notes
    add_column :business_ownerships, :requester_id, :integer
    add_column :business_ownerships, :reviewer_id, :integer
  end
end
