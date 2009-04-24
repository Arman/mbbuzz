class HoboMigration18 < ActiveRecord::Migration
  def self.up
    create_table :locations do |t|
      t.string   :address_line_1
      t.string   :address_line_2
      t.string   :city
      t.string   :zip_code
      t.string   :state_region
      t.string   :country
      t.datetime :created_at
      t.datetime :updated_at
    end
    
    add_column :categories, :icon, :string
  end

  def self.down
    remove_column :categories, :icon
    
    drop_table :locations
  end
end
