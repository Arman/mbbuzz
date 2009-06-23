class FrontController < ApplicationController

  hobo_controller

  def index  
    @recent_reviews = Review.recent.limit(4)
    @top_businesses = Business.top_rated.limit(4)
    @recent_people = Person.recent.limit(4)
    @recent_businesses = Business.recent.limit(4)
  end

  def site_search
    if params[:query]
      site_search(params[:query])
    end
  end

end
