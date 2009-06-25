class AdminDashboardController < ApplicationController

  hobo_controller

  def index  
    @business_ownership_claims_in_review = BusinessOwnership.state_is("in_review")
    @professional_profile_ownership_claims_in_review = ProfessionalProfileOwnership.state_is("in_review")
  end

  def site_search
    if params[:query]
      site_search(params[:query])
    end
  end

end
