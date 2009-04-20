class OrganizationHints < Hobo::ViewHints
  
  model_name "Business"
  field_names :state_region => "State", :address_line_1 => "Address", :address_line_2 => "Address Ln 2" 

end
