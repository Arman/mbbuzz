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
  # The 'owner' of a successful claim
  belongs_to :owner, :class_name => "User"   
  
  named_scope :state_is, lambda {|*args| {:conditions => ["business_ownerships.state like :state" , {:state =>   if args.first then args.first else '%' end}]}}

  named_scope :claimed_by, lambda { 
                                                    |user_id| 
                                                      return {} if user_id.blank?; 
                                                      {:include => :claimant, 
                                                        :conditions => ["claimant_id = :user_id" , {:user_id => user_id}]
                                                      } 
                                                  }
                                                  
    named_scope :owned_by, lambda { 
                                                    |user_id| 
                                                      return {} if user_id.blank?; 
                                                      {:include => :owner, 
                                                        :conditions => ["owner_id = :user_id" , {:user_id => user_id}]
                                                      } 
                                                  } 
                                                  
  named_scope :limit, lambda { |num| { :limit => num }} 


  lifecycle do     
    state :in_review, :active, :unclaimed, :contested
    
    create :claim, :params => [ :business, :acknowledge ], :become => :in_review,                      
      :available_to => "User",
      :user_becomes => :claimant 
      
    transition :accept,{ :in_review => :active },
      :params => [ :notes ],
      :available_to => "User",
      :user_becomes => :reviewer do
      self.update_attribute(:owner_id, self.claimant_id)
    end
    
    transition :accept,{ :contested => :active },
      :params => [ :notes ],
      :available_to => "User",
      :user_becomes => :reviewer do
      self.update_attribute(:owner_id, self.claimant_id)
    end
    
    transition :reject,{ :in_review => :unclaimed },
      :params => [ :notes ],
      :available_to => "User",
      :user_becomes => :reviewer
      
    transition :reject,{ :contested => :active },
      :params => [ :notes ],
      :available_to => "User",
      :user_becomes => :reviewer  
    

    transition :contest, { :active => :contested },
      :available_to => "User",
      :user_becomes => :claimant     
  end 

  # --- TO DO: Lifecycle Validations --- #
  # --- Claim: Validate that ownership claim is first one for a business if not then execute contest action instead. --- #
  
  # --- TO DO: Lifecycle History --- #
  # --- Keep history of changes to business ownership. Date contested, contested by. these can be automatically added to a history field or as a seperate object  --- #  
  
  
  # --- Permissions --- #

  def create_permitted?
    acting_user.signed_up?
  end

  def update_permitted?
    acting_user.administrator? || owner_is?(acting_user)
  end

  def destroy_permitted?
    acting_user.administrator?
  end

  def view_permitted?(field)
    # true ||  
    acting_user.administrator? || owner_is?(acting_user) || claimant_is?(acting_user)  || claimant.nil?
  end

end
