class HoboMigration7 < ActiveRecord::Migration
  def self.up
    add_column :organizations, :about, :text
  end

  def self.down
    remove_column :organizations, :about
  end
end
