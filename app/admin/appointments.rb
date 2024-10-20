ActiveAdmin.register Appointment do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :patient_id, :problem, :doctor_id, :appointment_status, :appointment_timing, :consultancy_fees, :appointment_type, :ward_id, :bed_id, :hospital_registration_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:patient_id, :problem, :doctor_id, :appointment_status, :appointment_timing, :consultancy_fees, :appointment_type, :ward_id, :bed_id, :hospital_registration_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
