class OwnerDashboardController < ApplicationController

  hobo_controller

  def index  
    
    @recent_reviews = Review.recent.limit(2)
    
    @business_ownership_claims_in_review = BusinessOwnership.state_is("in_review").claimed_by(current_user)
    @active_business_ownerships = BusinessOwnership.state_is("active").owned_by(current_user)
    
    @professional_profile_ownership_claims_in_review = ProfessionalProfileOwnership.state_is("in_review").claimed_by(current_user)
    @active_professional_profile_ownerships = ProfessionalProfileOwnership.state_is("active").owned_by(current_user)
    
  end

=begin
  def site_search
    if params[:query]
      site_search(params[:query])
    end
  end
=end

end
