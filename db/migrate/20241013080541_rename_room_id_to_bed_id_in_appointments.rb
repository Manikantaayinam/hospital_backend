class RenameRoomIdToBedIdInAppointments < ActiveRecord::Migration[7.1]
  def change
    rename_column :appointments, :room_id, :bed_id
  end
end
