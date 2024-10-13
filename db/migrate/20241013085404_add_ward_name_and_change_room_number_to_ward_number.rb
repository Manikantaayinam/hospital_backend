class AddWardNameAndChangeRoomNumberToWardNumber < ActiveRecord::Migration[7.1]
  def change
     add_column :wards, :ward_name, :string

    # Rename the room_number column to ward_number
    rename_column :wards, :room_number, :ward_number
  end
end
