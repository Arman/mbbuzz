class BusinessOwnership < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    acknowledge :boolean
    notes :text
    timestamps
  end

  # The 'business' that is being claimed  
  belongs_to :business

  # The 'sender' of the claim   
  belongs_to :claimant, :class_name => "User"   
  # The 'reviewer' of the claim   
  belongs_to :reviewer, :class_name => "User"   

  lifecycle do     
    state :in_review, :active, :unclaimed, :contested
    
    create :claim, :params => [ :business, :acknowledge ], :become => :in_review,                      
      :available_to => "User"
=begin
      ,                      
      :user_becomes => :claimant 
      
    transition :accept, { :in_review => :active }, 
      :available_to => :reviewer 
    transition :reject, { :in_review => :unclaimed }, 
      :available_to => :reviewer  
    transition :contest, { :active => :contested }, :available_to => "User"    
=end
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
