class Person < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    first_name :string, :name => true 
    last_name  :string
    professional_title  :string
    bio        :text
    timestamps
  end
  
  # has_many :reviews, :as => :reviewable, :dependent => :destroy, :accessible => :true
  has_many :employments, :dependent => :destroy  
  has_many :employers, :through => :employments, :uniq => true, :source => :business

  named_scope :named, lambda {|*args| {:conditions => ["name like :name" , {:name =>   if args.first then '%'+args.first+'%' else '%' end}]}}
  named_scope :limit, lambda { |num| { :limit => num }} 
  named_scope :recent, {:order => 'created_at DESC' } 
  
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
