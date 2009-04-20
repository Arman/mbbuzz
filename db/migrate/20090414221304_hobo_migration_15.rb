class HoboMigration15 < ActiveRecord::Migration
  def self.up
    create_table :business_ownerships do |t|
      t.datetime :created_at
      t.datetime :updated_at
      t.integer  :business_id
      t.integer  :requester_id
      t.integer  :reviewer_id
    end
    
    create_table :pages do |t|
      t.string   :name
      t.string   :permalink
      t.text     :content
      t.datetime :created_at
      t.datetime :updated_at
    end
    
    remove_column :reviews, :organization_id
  end

  def self.down
    add_column :reviews, :organization_id, :integer
    
    drop_table :business_ownerships
    drop_table :pages
  end
end
