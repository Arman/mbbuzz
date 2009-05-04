class MessageCopy < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    timestamps
  end
  
  belongs_to :message
  belongs_to :recipient, :class_name => "User"
  belongs_to :folder
  delegate :author, :created_at, :subject, :body, :recipients, :to => :message


  # --- Permissions --- #

  def create_permitted?
    acting_user.administrator?
  end

  def update_permitted?
    acting_user.administrator?
  end

  def destroy_permitted?
    acting_user.administrator?
  end

  def view_permitted?(field)
    true
  end

end
