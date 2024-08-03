ActiveAdmin.register HospitalRegistration do

  # Permitted parameters
  permit_params :hos_name, :email, :password, :password_confirmation,:role, :phone_number, :location, :plaintext_password
  
  # Index page
  index do
    selectable_column
    id_column
    column :hos_name
    column :email
    column :location
    column :role
    column :phone_number
    column :password do |hospital_registration|
      hospital_registration.plaintext_password
    end
    actions
  end

  # Form for creating and editing
  form do |f|
    f.inputs do
      f.input :hos_name
      f.input :email
      f.input :location
      f.input :phone_number
      f.input :password
      f.input :password_confirmation
      # Optionally include plaintext_password if needed for your use case
      # f.input :plaintext_password
    end
    f.actions
  end

end
