class MailboxController < ApplicationController
  
  hobo_controller
  
  def index
    redirect_to new_session_path and return unless logged_in?
    @folder = current_user.inbox
    show
    render :action => "show"
  end

  def show
    @folder ||= current_user.folders.find(params[:id])
    @messages = @folder.messages.paginate :per_page => 10, :page => params[:page], :include => :message, :order => "messages.created_at DESC"
  end
end
