ActiveAdmin.register Patient do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
   permit_params :name, :gender, :occupation, :email, :address, :phone_number, :role, :hospital_registration_id, :paymentstatus, :password_digest, :age
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :gender, :occupation, :email, :address, :phone_number, :role, :hospital_registration_id, :paymentstatus, :password_digest, :age]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
