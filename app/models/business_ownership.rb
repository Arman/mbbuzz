class Business_Ownership < ActiveRecord::Base

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
  # The 'owner' of a successful claim
  belongs_to :owner, :class_name => "User"   
  
  named_scope :state_is, lambda {|*args| {:conditions => ["state = :state" , {:state =>   if args.first then '%'+args.first+'%' else '%' end}]}}

  named_scope :claimed_by, lambda { 
                                                    |claimant_id| 
                                                      return {} if claimant_id.blank?; 
                                                      {:select => 'DISTINCT businesses.*', 
                                                        :include => :claimant, 
                                                        :conditions => ["user.id = :claimant_id" , {:claimant_id => claimant_id}]
                                                      } 
                                                  }

  lifecycle do     
    state :in_review, :active, :unclaimed, :contested
    
    create :claim, :params => [ :business, :acknowledge ], :become => :in_review,                      
      :available_to => "User",
      :user_becomes => :claimant 
      
    transition :accept, { :in_review => :active }, 
      :available_to => "Administrator",
      :user_becomes => :reviewer,
      :claimant_becomes => :owner
    
    transition :reject, { :in_review => :unclaimed }, 
      :available_to => "Administrator",
      :user_becomes => :reviewer

    transition :contest, { :active => :contested },
      :available_to => "User",
      :user_becomes => :claimant     
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
