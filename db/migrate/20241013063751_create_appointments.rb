class CreateAppointments < ActiveRecord::Migration[7.1]
  def change
    create_table :appointments do |t|
      t.integer :patient_id
      t.text :problem
      t.integer :doctor_id
      t.string :appointment_status
      t.datetime :appointment_timing
      t.decimal :consultancy_fees

      t.timestamps
    end
  end
end
