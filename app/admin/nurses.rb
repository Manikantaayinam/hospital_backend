ActiveAdmin.register Nurse do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :name, :address, :phone_number, :email, :hospital_registration_id, :profile, :role, :deleted_at, :status
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :address, :phone_number, :email, :hospital_registration_id, :profile, :role, :deleted_at, :status]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  index do
    selectable_column
    id_column
    column :name
    column :address
    column :phone_number
    column :role
    column :email
    column :status
    column :hospital_registration_id
   
    actions
  end
end
