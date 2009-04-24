class SearchController < ApplicationController

  hobo_controller
  include Geokit::Mappable
  include Geokit::Geocoders

  def index                                          
    #@search_results = Business.located_at("%"+params[:location]+"%").named("%"+params[:search_string]+"%").in_category(params[:category_id])    
    @search_results = Business.find(:all, :origin => params[:location], :within => 25)
    #.named("%"+params[:search_string]+"%").in_category(params[:category_id])    
    @category_list = Category.find(:all)  
    
    # The following local vars are used to pass on search parameters to filter requests.
    @search_string = params[:search_string]
    @location = params[:location]
# Need to modify this to center on searched location
    #@search_center={:latitude => 37.700, :longitude => 237.750}
     @search_center={params[:location]}
#    @markers = [[-34.2023, 18.3794], [-34.2029, 18.3797], [-34.2022, 18.3811],[-34.2016, 18.3829], [-34.2006, 18.3849]].collect
    items = [*@search_results]
    @markers =  items.collect do |item|
         [item.lat, item.lng]
        end 
  end

end
