class Message < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    subject :string
    body    :text
    timestamps
  end
  
  belongs_to :author, :class_name => "User"
  has_many :message_copies
  has_many :recipients, :through => :message_copies
  
  before_create :prepare_copies
  
  attr_accessor :to #array of users
  attr_accessible :subject, :body, :to
  
  def prepare_copies 
    return if to.blank?
    to.each do |recipient|
      recipient = User.find(recipient)
      message_copies.build(:recipient_id => recipient.id, :folder_id => recipient.inbox.id)
    end
  end

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
