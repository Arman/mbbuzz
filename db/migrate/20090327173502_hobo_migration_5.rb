class HoboMigration5 < ActiveRecord::Migration
  def self.up
    add_column :users, :about_me, :text
  end

  def self.down
    remove_column :users, :about_me
  end
end
