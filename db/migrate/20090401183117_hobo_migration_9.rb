class HoboMigration9 < ActiveRecord::Migration
  def self.up
    create_table :categories do |t|
      t.string   :name
      t.datetime :created_at
      t.datetime :updated_at
    end
    
    create_table :category_organizations do |t|
      t.datetime :created_at
      t.datetime :updated_at
      t.integer  :category_id
      t.integer  :organization_id
    end
  end

  def self.down
    drop_table :categories
    drop_table :category_organizations
  end
end
