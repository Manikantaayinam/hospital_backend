class AddHospitalRegistrationIdToAppointments < ActiveRecord::Migration[7.1]
  def change
    add_column :appointments, :hospital_registration_id, :string
  end
end
