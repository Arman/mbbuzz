class HoboMigration13 < ActiveRecord::Migration
  def self.up
    add_column :reviews, :business_id, :integer
  end

  def self.down
    remove_column :reviews, :business_id
  end
end
