class AddHospitalRegistrationIdToDoctors < ActiveRecord::Migration[7.1]
  def change
    add_column :doctors, :hospital_registration_id, :integer
  end
end
