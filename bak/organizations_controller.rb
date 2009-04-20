class OrganizationsController < ApplicationController

  hobo_model_controller

  auto_actions :all
  
  def index
    @organizations = Organization.located_at(params[:location]).named(params[:search_string]).in_category(params[:category_id]) 
    hobo_index(@organizations)
    @category_list = Category.find(:all)  
    @business = params[:business]
    @location = params[:location]
  end
  
  
  
  def new
    hobo_new
    rescue ActiveRecord::RecordInvalid => error
      logger.error("Attempt to create invalid category organization record" )
      flash[:notice] = "Same category can't be selected multiple times."
      redirect_to :action => 'new'
  end
  
  def update
    hobo_update
    rescue ActiveRecord::RecordInvalid => error
      logger.error("Attempt to create invalid category organization record" )
      flash[:notice] = "Same category can't be selected multiple times."
      redirect_to :action => 'edit'
  end

end
