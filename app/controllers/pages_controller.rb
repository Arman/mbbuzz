class PagesController < ApplicationController

  hobo_model_controller

  auto_actions :all, :except => :index
  
  def show
    if params[:permalink]
      @page=Page.find_by_permalink(params[:permalink])
    else
      hobo_show
    end
      hobo_show(@page)
  end

end
