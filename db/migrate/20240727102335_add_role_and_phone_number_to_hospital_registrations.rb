class AddRoleAndPhoneNumberToHospitalRegistrations < ActiveRecord::Migration[7.1]
  def change
    add_column :hospital_registrations, :role, :string
    add_column :hospital_registrations, :phone_number, :bigint
  end
end
