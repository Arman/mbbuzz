class HoboMigration25 < ActiveRecord::Migration
  def self.up
    change_column :businesses, :lng, :decimal, :precision => 10, :default => 0, :scale => 7
    change_column :businesses, :lat, :decimal, :precision => 10, :default => 0, :scale => 7
    change_column :businesses, :avg_rating, :decimal, :precision => 3, :default => 0, :scale => 1
    
    add_column :business_ownerships, :claimant_id, :integer
    add_column :business_ownerships, :reviewer_id, :integer
    add_column :business_ownerships, :owner_id, :integer
    add_column :business_ownerships, :state, :string
    add_column :business_ownerships, :key_timestamp, :datetime
  end

  def self.down
    change_column :businesses, :lng, :decimal, :default => 0.0
    change_column :businesses, :lat, :decimal, :default => 0.0
    change_column :businesses, :avg_rating, :decimal, :default => 0.0
    
    remove_column :business_ownerships, :claimant_id
    remove_column :business_ownerships, :reviewer_id
    remove_column :business_ownerships, :owner_id
    remove_column :business_ownerships, :state
    remove_column :business_ownerships, :key_timestamp
  end
end
