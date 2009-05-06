class ServiceSchedule < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    start_date  :date
    start_time  :time
    recurring :boolean
    interval :string 
    frequency :integer
    price :decimal
    timestamps
  end

  belongs_to :service

  # --- Permissions --- #

  def create_permitted?
    acting_user.administrator?
  end

  def update_permitted?
    acting_user.administrator?
  end

  def destroy_permitted?
    acting_user.administrator?
  end

  def view_permitted?(field)
    true
  end

end
