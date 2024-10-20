ActiveAdmin.register Ward do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
   permit_params :available_beds, :ward_number, :hospital_registration_id, :ward_name
  #
  # or
  #
  # permit_params do
  #   permitted = [:available_beds, :ward_number, :hospital_registration_id, :ward_name]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
