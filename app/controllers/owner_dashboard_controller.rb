class OwnerDashboardController < ApplicationController

  hobo_controller

  def index  
    @recent_reviews = Review.recent.limit(2)
    @business_ownerships_in_review = BusinessOwnership.state_is("in_review").claimed_by_acting_user
  end

  def site_search
    if params[:query]
      site_search(params[:query])
    end
  end

end
