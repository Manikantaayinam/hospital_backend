class AddHospitalRegistrationIdToWards < ActiveRecord::Migration[7.1]
  def change
    add_column :wards, :hospital_registration_id, :integer
  end
end
