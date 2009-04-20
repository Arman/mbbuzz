class ReviewsController < ApplicationController

  hobo_model_controller

  auto_actions :all
  
  auto_actions_for :business, [:index, :new, :create] 
  
  auto_actions_for :reviewer, :index

end
