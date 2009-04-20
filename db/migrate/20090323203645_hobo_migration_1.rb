class HoboMigration1 < ActiveRecord::Migration
  def self.up
    create_table :organizations do |t|
      t.string   :name
      t.string   :address_line_1
      t.string   :address_line_2
      t.string   :city
      t.string   :state_region
      t.string   :country
      t.string   :web_site
      t.string   :phone
      t.string   :fax
      t.datetime :created_at
      t.datetime :updated_at
      t.integer  :owner_id
    end
    
    create_table :reviews do |t|
      t.string   :name
      t.integer  :rating
      t.text     :body
      t.datetime :created_at
      t.datetime :updated_at
      t.integer  :organization_id
      t.integer  :reviewer_id
    end
    
    create_table :users do |t|
      t.string   :crypted_password, :limit => 40
      t.string   :salt, :limit => 40
      t.string   :remember_token
      t.datetime :remember_token_expires_at
      t.string   :name
      t.string   :email_address
      t.boolean  :administrator, :default => false
      t.datetime :created_at
      t.datetime :updated_at
      t.string   :state, :default => "active"
      t.datetime :key_timestamp
    end
  end

  def self.down
    drop_table :organizations
    drop_table :reviews
    drop_table :users
  end
end
