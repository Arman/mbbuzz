class Business < ActiveRecord::Base

  hobo_model # Don't put anything above this
    
  fields do
    name           :string
    about       :text
    address_line_1 :string
    address_line_2 :string
    city           :string
    zip_code    :string
    state_region   :string
    country        :string, :default => 'US'
    web_site       :string
    phone          :string
    fax            :string
    avg_rating  :decimal,:precision => 3, :scale => 1, :default => 0
    lat :decimal,:precision => 10, :scale => 7, :default => 0
    lng :decimal,:precision => 10, :scale => 7, :default => 0
    photo_file_name :string
    photo_content_type :string
    photo_file_size :integer
    photo_updated_at :datetime
    timestamps
  end
  
  acts_as_mappable 
  before_validation :geocode_address
  
  belongs_to :owner, :class_name => "User", :creator => true 
  has_many :reviews, :dependent => :destroy, :accessible => :true
  # has_many :business_ownerships, :dependent => :destroy, :accessible => :true
  # has_many :reviews, :as => :reviewable, :dependent => :destroy, :accessible => :true
  has_many :services, :dependent => :destroy, :accessible => :true
  has_many :employments, :dependent => :destroy  
  has_many :employees, :through => :employments, :uniq => true,:accessible => true, :source => :person
  has_many :business_categories, :dependent => :destroy   
  has_many :categories, :through => :business_categories, :uniq => true, :accessible => true
  has_attached_file :photo, 
    :styles => {:normal => ["296x200#", :jpg], :thumb => ["74x50#", :jpg]}, 
    :url => "/system/user_assets/:class/:attachment/:id/:style_:basename.:extension",
    :path => ":rails_root/public/system/user_assets/:class/:attachment/:id/:style_:basename.:extension",
    :default_url => ":rails_root/public/system/user_assets/:class/:attachment/:style/missing.png"  

  named_scope :located_at, lambda {|*args| {:conditions => ["(city like :location or state_region like :location or zip_code like :location)" , {:location => if args.first then '%'+args.first+'%' else '%' end}]}}
  named_scope :named, lambda {|*args| {:conditions => ["name like :name" , {:name =>   if args.first then '%'+args.first+'%' else '%' end}]}}
  named_scope :in_category, lambda { 
                                                    |category_id| 
                                                      return {} if category_id.blank?; 
                                                      {:select => 'DISTINCT businesses.*', 
                                                        :include => :business_categories, 
                                                        :conditions => ["business_categories.category_id = :category_id" , {:category_id => category_id}]
                                                      } 
                                                  }
  named_scope :top_rated, {:order => 'avg_rating DESC' } 
  named_scope :limit, lambda { |num| { :limit => num }} 
  named_scope :recent, {:order => 'created_at DESC' } 

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
  
  private
  def geocode_address
    address= [address_line_1, address_line_2, city, state_region, zip_code, country].join(', ')
    logger.info(address)
    #address='31 tareyton Ct,, San Ramon, CA, 94583,'
    geo=Geokit::Geocoders::MultiGeocoder.geocode(address)
    errors.add(:address, "Could not Geocode address") if !geo.success
    self.lat, self.lng = geo.lat,geo.lng if geo.success
  end
  
end
