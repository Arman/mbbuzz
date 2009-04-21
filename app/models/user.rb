class User < ActiveRecord::Base

  hobo_user_model # Don't put anything above this

  fields do
    name :string, :unique
    first_name :string
    last_name :string
    email_address :email_address, :unique, :login => true
    administrator :boolean, :default => false
    about_me :text
    avatar_file_name :string
    avatar_content_type :string
    avatar_file_size :integer
    avatar_updated_at :datetime
    timestamps
  end
  
    has_many :reviews, :class_name => "Review", :foreign_key => "reviewer_id"
    has_many :business_employees, :dependent => :destroy   
    has_many :employers, :through => :business_employees, :uniq => true, :accessible => true, :source => :business
    has_attached_file :avatar, 
    :styles => {:med=> ["100x75#", :jpg], :small => ["40x40#", :jpg],:xsmall => ["20x20#", :jpg]}, 
    :url => "/system/user_assets/:class/:attachment/:id/:style_:basename.:extension",
    :path => ":rails_root/public/system/user_assets/:class/:attachment/:id/:style_:basename.:extension"  

  # This gives admin rights to the first sign-up.
  # Just remove it if you don't want that
  before_create { |user| user.administrator = true if RAILS_ENV != "test" && count == 0 }
  
  
  # --- Signup lifecycle --- #

  lifecycle do

    state :active, :default => true

    create :signup, :available_to => "Guest",
           :params => [:name, :email_address, :password, :password_confirmation],
           :become => :active

    transition :request_password_reset, { :active => :active }, :new_key => true do
      UserMailer.deliver_forgot_password(self, lifecycle.key)
    end

    transition :reset_password, { :active => :active }, :available_to => :key_holder,
               :params => [ :password, :password_confirmation ]

  end
  

  # --- Permissions --- #

  def create_permitted?
    false
  end

  def update_permitted?
    acting_user.administrator? || (acting_user == self && only_changed?(:crypted_password, :email_address,:about_me, :avatar_file_name, :avatar_content_type, :avatar_file_size, :avatar_updated_at ))
    # Note: crypted_password has attr_protected so although it is permitted to change, it cannot be changed
    # directly from a form submission.
  end

  def destroy_permitted?
    acting_user.administrator?
  end

  def view_permitted?(field)
    true
  end

end
