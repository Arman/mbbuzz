class Employment < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    start_date :date
    end_date :date
    timestamps
  end

    belongs_to :business
    belongs_to :person

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
