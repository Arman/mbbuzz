class HoboMigration12 < ActiveRecord::Migration
  def self.up
    create_table :business_categories do |t|
      t.datetime :created_at
      t.datetime :updated_at
      t.integer  :category_id
      t.integer  :business_id
    end
  end

  def self.down
    drop_table :business_categories
  end
end
