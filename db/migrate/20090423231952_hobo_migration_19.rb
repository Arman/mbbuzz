class HoboMigration19 < ActiveRecord::Migration
  def self.up
    rename_column :businesses, :latitude, :lat
    rename_column :businesses, :longitude, :lng
    change_column :businesses, :lat, :decimal, :precision => 9, :default => 0, :scale => 6, :limit => nil
    change_column :businesses, :lng, :decimal, :precision => 9, :default => 0, :scale => 6, :limit => nil
  end

  def self.down
    rename_column :businesses, :lat, :latitude
    rename_column :businesses, :lng, :longitude
    change_column :businesses, :latitude, :decimal, :precision => 6, :scale => 3, :default => 0.0
    change_column :businesses, :longitude, :decimal, :precision => 6, :scale => 3, :default => 0.0
  end
end
