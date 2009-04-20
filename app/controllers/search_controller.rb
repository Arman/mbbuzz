class SearchController < ApplicationController

  hobo_controller

  def index                                          
    @search_results = Organization.located_at("%"+params[:location]+"%").named("%"+params[:search_string]+"%").in_category(params[:category_id])    
    @category_list = Category.find(:all)  
    
    # The following local vars are used to pass on search parameters to filter requests.
    @search_string = params[:search_string]
    @location = params[:location]
    @search_center={:latitude => 41.100, :longitude => 29.000}
    
  end

end
