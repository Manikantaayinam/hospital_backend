class AddDetailsToAppointments < ActiveRecord::Migration[7.1]
  def change
    add_column :appointments, :appointment_type, :string
    add_column :appointments, :ward_id, :integer
    add_column :appointments, :room_id, :integer
  end
end
