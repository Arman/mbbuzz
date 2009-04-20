class Organization < ActiveRecord::Base

  hobo_model # Don't put anything above this
  
  fields do
    name           :string
    address_line_1 :string
    address_line_2 :string
    city           :string
    zip_code    :string
    state_region   :string
    country        :string
    web_site       :string
    phone          :string
    fax            :string
    avg_rating  :decimal,:precision => 3, :scale => 1, :default => 0
    about       :text
    photo_file_name :string
    photo_content_type :string
    photo_file_size :integer
    photo_updated_at :datetime
    timestamps
  end
  
  has_many :reviews, :dependent => :destroy, :accessible => :true
  belongs_to :owner, :class_name => "User", :creator => true 
  has_many :category_organizations, :dependent => :destroy   
  has_many :categories, :through => :category_organizations, :uniq => true, :accessible => true
  has_attached_file :photo, 
    :styles => {:normal => ["296x200#", :jpg], :thumb => ["74x50#", :jpg]}, 
    :url => "/user_assets/:class/:attachment/:id/:style_:basename.:extension",
    :path => ":rails_root/public/user_assets/:class/:attachment/:id/:style_:basename.:extension"  

  # named_scope :located_at, lambda {|location| {:conditions => ["(city like :location or state_region like :location or zip_code like :location)" , {:location => location}]}}
  # named_scope :named, lambda {|search_string| {:conditions => ["name like :name" , {:name => search_string}]}}
  named_scope :located_at, lambda {|*args| {:conditions => ["(city like :location or state_region like :location or zip_code like :location)" , {:location => if args.first then '%'+args.first+'%' else '%' end}]}}
  named_scope :named, lambda {|*args| {:conditions => ["name like :name" , {:name =>   if args.first then '%'+args.first+'%' else '%' end}]}}
  
  named_scope :in_category, lambda { 
                                                    |category_id| 
                                                      return {} if category_id.blank?; 
                                                      {:select => 'DISTINCT organizations.*', 
                                                        :include => :category_organizations, 
                                                        :conditions => ["category_organizations.category_id = :category_id" , {:category_id => category_id}]
                                                      } 
                                                  }
  named_scope :limit, lambda { |num| { :limit => num }} 
                                                                        
      
  validates_presence_of :name, :city
#  validates_attachment_presence :photo
  
  attr_readonly(:about_short, :average_review_rating, :big_star, :small_star)  
  
  def about_short
     if about
      return about.first(360)+'...' unless about.length<=360
      about.to_s
    else
      ""
    end
  end 
  
  def big_star
   avg_rating.to_i/2
  end
  
  def small_star 
    avg_rating.to_i%2
  end

  def average_review_rating
     self.reviews.average(:rating)
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