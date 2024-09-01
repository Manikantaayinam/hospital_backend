class AddHospitalRegistrationIdToReceptionist < ActiveRecord::Migration[7.1]
  def change
    add_column :receptionists, :hospital_registration_id, :integer
  end
end
