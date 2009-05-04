class MessagesController < ApplicationController

  hobo_model_controller

  auto_actions :all
  
  def show
    @message = current_user.received_messages.find(params[:id])
  end
  
end

