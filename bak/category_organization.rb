class CategoryOrganization < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    timestamps
  end

  belongs_to :category   
  belongs_to :organization
  
  validates_uniqueness_of :category_id, :scope => :organization_id, :message => "Same category can't be selected multiple times."

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
