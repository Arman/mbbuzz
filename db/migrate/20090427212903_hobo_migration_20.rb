class HoboMigration20 < ActiveRecord::Migration
  def self.up
    drop_table :business_employees
    
    create_table :employments do |t|
      t.datetime :created_at
      t.datetime :updated_at
      t.integer  :business_id
      t.integer  :person_id
    end
    
    create_table :people do |t|
      t.string   :first_name
      t.string   :last_name
      t.text     :bio
      t.datetime :created_at
      t.datetime :updated_at
    end
    
    change_column :businesses, :country, :string, :default => "US", :limit => 255
    change_column :businesses, :lng, :decimal, :precision => 10, :default => 0, :scale => 7
    change_column :businesses, :lat, :decimal, :precision => 10, :default => 0, :scale => 7
    change_column :businesses, :avg_rating, :decimal, :precision => 3, :default => 0, :scale => 1
  end

  def self.down
    change_column :businesses, :country, :string
    change_column :businesses, :lng, :decimal, :default => 0.0
    change_column :businesses, :lat, :decimal, :default => 0.0
    change_column :businesses, :avg_rating, :decimal, :default => 0.0
    
    create_table "business_employees", :force => true do |t|
      t.datetime "created_at"
      t.datetime "updated_at"
      t.integer  "business_id"
      t.integer  "user_id"
    end
    
    drop_table :employments
    drop_table :people
  end
end
