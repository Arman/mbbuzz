class BusinessEmployee < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    timestamps
  end
  
  belongs_to :business
  belongs_to :user

  validates_uniqueness_of :user_id, :scope => :business_id, :message => "Same employee can not be selected multiple times."


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
