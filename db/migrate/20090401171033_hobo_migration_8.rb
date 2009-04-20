class HoboMigration8 < ActiveRecord::Migration
  def self.up
    add_column :organizations, :zip_code, :string
    
    remove_column :reviews, :name
  end

  def self.down
    remove_column :organizations, :zip_code
    
    add_column :reviews, :name, :string
  end
end
