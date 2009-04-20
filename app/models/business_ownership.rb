class BusinessOwnership < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    timestamps
  end

  # The 'business' that is being requested  
  belongs_to :business
  # The 'sender' of the request   
  belongs_to :requester, :class_name => "User"   
  # The 'reviewer' of the request   
  belongs_to :reviewer, :class_name => "User"   
  
=begin
  lifecycle do     
    state :requested, :active, :rejected, :retracted
    
    create :request, :params => [ :requester ], :become => :requested,                      
      :available_to => "User",                      
      :user_becomes => :requester 
      
    transition :accept, { :requested => :active }, 
      :available_to => :reviewer 
    transition :reject, { :requested => :rejected }, 
      :available_to => :reviewer  
    transition :retract, { :requested => :retracted }, :available_to => :requester    
  end 
=end

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
