ActiveAdmin.register Doctor do
  # Permit the parameters you want to allow through ActiveAdmin
  permit_params :name, :address, :phone_number, :role, :email, :password, :password_confirmation, :specialist_in

  # Define the index page
  index do
    selectable_column
    id_column
    column :name
    column :address
    column :phone_number
    column :role
    column :email
    column :specialist_in
    column :password do |doctor|
      doctor.plaintext_password
    end
    actions
  end

  # Define the form for creating/editing records
  form do |f|
    f.inputs 'Doctor Details' do
      f.input :name
      f.input :address
      f.input :phone_number
      f.input :role
      f.input :email
      f.input :specialist_in

      # Display password fields
      f.input :password
      f.input :password_confirmation, label: 'Confirm Password'
    end
    f.actions
  end

  # Override controller to handle password processing
  controller do
    def create
      @doctor = Doctor.new(permitted_params[:doctor])

      if @doctor.save
        redirect_to admin_doctor_path(@doctor), notice: 'Doctor was successfully created.'
      else
        render :new
      end
    end

    def update
      @doctor = Doctor.find(params[:id])

      if @doctor.update(permitted_params[:doctor])
        redirect_to admin_doctor_path(@doctor), notice: 'Doctor was successfully updated.'
      else
        render :edit
      end
    end
  end
end
