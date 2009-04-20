class HoboMigration10 < ActiveRecord::Migration
  def self.up
    add_column :categories, :desc, :string
    add_column :categories, :about, :text
  end

  def self.down
    remove_column :categories, :desc
    remove_column :categories, :about
  end
end
