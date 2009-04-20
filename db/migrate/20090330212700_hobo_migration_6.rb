class HoboMigration6 < ActiveRecord::Migration
  def self.up
    add_column :organizations, :avg_rating, :decimal, :scale => 1, :default => 0, :precision => 3
  end

  def self.down
    remove_column :organizations, :avg_rating
  end
end
