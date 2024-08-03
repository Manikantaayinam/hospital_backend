class CreateHospitalRegistrations < ActiveRecord::Migration[7.1]
  def change
    create_table :hospital_registrations do |t|
      t.string :hos_name
      t.string :email
      t.string :password_digest
      t.string :location
      t.string :plaintext_password

      t.timestamps
    end
  end
end
