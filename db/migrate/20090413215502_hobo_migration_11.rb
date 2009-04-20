class HoboMigration11 < ActiveRecord::Migration
  def self.up
    create_table :businesses do |t|
      t.string   :name
      t.text     :about
      t.string   :address_line_1
      t.string   :address_line_2
      t.string   :city
      t.string   :zip_code
      t.string   :state_region
      t.string   :country
      t.string   :web_site
      t.string   :phone
      t.string   :fax
      t.decimal  :avg_rating, :scale => 1, :default => 0, :precision => 3
      t.decimal  :latitude, :scale => 3, :default => 0, :precision => 6
      t.decimal  :longitude, :scale => 3, :default => 0, :precision => 6
      t.string   :photo_file_name
      t.string   :photo_content_type
      t.integer  :photo_file_size
      t.datetime :photo_updated_at
      t.datetime :created_at
      t.datetime :updated_at
      t.integer  :owner_id
    end
  end

  def self.down
    drop_table :businesses
  end
end
