class Category < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do

    name :string
    desc :string
    about :text
    timestamps
  end

  has_many :business_categories, :dependent => :destroy   
  has_many :businesses, :through => :business_categories  
  
  attr_readonly(:plain_name) 


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
  
  def plain_name
     name.to_s
  end 

end
