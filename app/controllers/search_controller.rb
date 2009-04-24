class SearchController < ApplicationController

  hobo_controller
  include Geokit::Mappable
  include Geokit::Geocoders

  def index                                          
    #@search_results = Business.located_at("%"+params[:location]+"%").named("%"+params[:search_string]+"%").in_category(params[:category_id])    
    if RAILS_ENV == "production" then @search_results = Business.named("%"+params[:search_string]+"%").in_category(params[:category_id]).find(:all, :origin => params[:location], :within => 25)
    else @search_results = Business.located_at("%"+params[:location]+"%").named("%"+params[:search_string]+"%").in_category(params[:category_id]) 
    end
    #.named("%"+params[:search_string]+"%").in_category(params[:category_id])    
    @category_list = Category.find(:all)  
    
    # The following local vars are used to pass on search parameters to filter requests.
    @search_string = params[:search_string]
    @location = params[:location]
    
    #Geocode search location if rails env is production otherwise use a default location
    geo=Geokit::Geocoders::MultiGeocoder.geocode(params[:location])
    errors.add(:address, "Could not Geocode address") if !geo.success
    @search_center={:latitude => geo.lat,  :longitude => geo.lng} 
    #dummy center @search_center={:latitude =>37.757763,  :longitude => -121.964991}
    
    #Create markers array from search results
    items = [*@search_results]
    @markers =  items.collect do |item|
         [item.lat, item.lng]
        end 
  end

end

