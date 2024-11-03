class AddHospitalRegistrationIdToPayments < ActiveRecord::Migration[7.1]
  def change
    add_column :payments, :hospital_registration_id, :string
  end
end
