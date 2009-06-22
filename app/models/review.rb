class Review < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do 
    #reviewable_id :integer
    #reviewable_type :integer
    rating :integer
    body   :text
    timestamps
  end
  
  never_show :reviewable_type

  belongs_to :business
  #belongs_to :reviewable, :polymorphic => true
  belongs_to :reviewer, :class_name => "User", :creator => true 
  
  named_scope :limit, lambda { |num| { :limit => num }} 
  named_scope :recent, {:order => 'created_at DESC' } 
  
  attr_readonly(:body_short,:big_star,:small_star)  
  
  def body_short
    return body.first(360)+'...' unless body.length<=360
    body.to_s
  end 
  
  def big_star
    rating/2
  end
  
  def small_star 
    rating%2
  end
  
  def after_save
    # shouldn't this update self.business? Changing as the next line - Arman 2009.06.22
    # self.review.update_attribute(:avg_rating, self.review.average_review_rating)
    self.business.update_attribute(:avg_rating, self.business.average_review_rating)
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
