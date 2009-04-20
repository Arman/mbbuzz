class HoboMigration17 < ActiveRecord::Migration
  def self.up
    rename_column :business_employees, :employee_id, :user_id
  end

  def self.down
    rename_column :business_employees, :user_id, :employee_id
  end
end
