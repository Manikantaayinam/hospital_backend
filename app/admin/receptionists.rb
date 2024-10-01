ActiveAdmin.register Receptionist do
  # Permit the parameters you want to allow through ActiveAdmin
  permit_params :name, :address, :phone_number, :role, :email, :password, :password_confirmation, :profile, :status

  # Define the index page
  index do
    selectable_column
    id_column
    column :name
    column :address
    column :phone_number
    column :role
    column :email
    column :status
    column :password do |receptionist|
      receptionist.plaintext_password
    end
    actions
  end

  # Define the form for creating/editing records
  form do |f|
    f.inputs 'Receptionist Details' do
      f.input :name
      f.input :address
      f.input :phone_number
      f.input :profile
      f.input :email
      f.input :password
      f.input :status
      f.input :password_confirmation
    end
    f.actions
  end
end
