class BusinessCategory < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do

    timestamps
  end

  belongs_to :category   
  belongs_to :business
  
  validates_uniqueness_of :category_id, :scope => :business_id, :message => "Same category can not be selected multiple times."



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
