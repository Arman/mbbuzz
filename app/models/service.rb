class Service < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    name     :string
    duration :integer
    price :decimal,:precision => 7, :scale => 2, :default => 0
    description :text
    timestamps
  end

  belongs_to :business
  has_many :service_schedules, :dependent => :destroy, :accessible => :true

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
