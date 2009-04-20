class FrontController < ApplicationController

  hobo_controller

  def index  
    @recent_reviews = Review.recent.limit(3)
    @top_businesses = Business.top_rated.limit(3)
    @recent_businesses = Business.recent.limit(3)
  end

  def site_search
    if params[:query]
      site_search(params[:query])
    end
  end

end
