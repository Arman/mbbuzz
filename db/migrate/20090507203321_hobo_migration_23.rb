class HoboMigration23 < ActiveRecord::Migration
  def self.up
    create_table :services do |t|
      t.string   :name
      t.integer  :duration
      t.decimal  :price, :precision => 7, :default => 0, :scale => 2
      t.text     :description
      t.datetime :created_at
      t.datetime :updated_at
      t.integer  :business_id
    end
    
    create_table :service_schedules do |t|
      t.date     :start_date
      t.time     :start_time
      t.boolean  :recurring
      t.string   :interval
      t.integer  :frequency
      t.decimal  :price
      t.datetime :created_at
      t.datetime :updated_at
      t.integer  :service_id
    end
    
    change_column :businesses, :lng, :decimal, :precision => 10, :default => 0, :scale => 7
    change_column :businesses, :lat, :decimal, :precision => 10, :default => 0, :scale => 7
    change_column :businesses, :avg_rating, :decimal, :precision => 3, :default => 0, :scale => 1
  end

  def self.down
    change_column :businesses, :lng, :decimal, :default => 0.0
    change_column :businesses, :lat, :decimal, :default => 0.0
    change_column :businesses, :avg_rating, :decimal, :default => 0.0
    
    drop_table :services
    drop_table :service_schedules
  end
end
