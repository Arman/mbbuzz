class Location < ActiveRecord::Base

  hobo_model # Don't put anything above this

# THIS MODEL IS CURRENTLY NOT USED
#I plan to use it to store location information for multiple models at a later date. \
#For example multiple location for a business, address of a person etc.

  fields do
    address_line_1 :string
    address_line_2 :string
    city           :string
    zip_code       :string
    state_region   :string
    country        :string
    timestamps
  end


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
