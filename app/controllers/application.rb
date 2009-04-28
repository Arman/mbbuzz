# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  
  helper :all # include all helpers, all the time
  
  include Geokit::Geocoders
  

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => 'cbce0ca60640369d9076de7221a93eb2'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password
  
  
  
  def geocode_address(address)
    if !address.blank? 
      geo=Geokit::Geocoders::MultiGeocoder.geocode(address)
      # errors.add(:address, "Could not Geocode address") if !geo.success
      return {:latitude => geo.lat,  :longitude => geo.lng}
=begin      
    elsif !user_ip_address.blank?
      geo = Geokit::Geocoders::IpGeocoder.geocode(user_ip_address)
      return {:latitude => geo.lat,  :longitude => geo.lng} 
=end
    else
      return {:latitude =>37.757763,  :longitude => -121.964991}
    end 
      #Geokit::Geocoders::IpGeocoder.geocode(user_ip_address)
      # errors.add(:address, "Could not Geocode address") if !geo.success
  end
  
  def user_ip_address
    return request.remote_ip()
  end
  
end
