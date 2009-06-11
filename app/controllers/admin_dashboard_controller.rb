class AdminDashboardController < ApplicationController

  hobo_controller

  def index  
    @recent_reviews = Review.recent.limit(2)
    @business_ownerships_in_review = Business_Ownership.in_review
  end

  def site_search
    if params[:query]
      site_search(params[:query])
    end
  end

end
