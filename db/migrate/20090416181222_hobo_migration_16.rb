class HoboMigration16 < ActiveRecord::Migration
  def self.up
    create_table :business_employees do |t|
      t.datetime :created_at
      t.datetime :updated_at
      t.integer  :business_id
      t.integer  :employee_id
    end
    
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
  end

  def self.down
    remove_column :users, :first_name
    remove_column :users, :last_name
    
    drop_table :business_employees
  end
end
