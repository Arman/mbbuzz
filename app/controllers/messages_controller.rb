class MessagesController < ApplicationController

  hobo_model_controller

  auto_actions :all
  
  def show
    @message = current_user.received_messages.find(params[:id])
  end
  
  def reply
    @original = current_user.received_messages.find(params[:id])
    
    subject = @original.subject.sub(/^(Re: )?/, "Re: ")
    body = @original.body.gsub(/^/, "> ")
    @message = current_user.sent_messages.build(:to => [@original.author.id], :subject => subject, :body => body)
    render :template => "sent/new"
  end

  
end

