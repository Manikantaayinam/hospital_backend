class CreateWards < ActiveRecord::Migration[7.1]
  def change
    create_table :wards do |t|
      t.integer :available_beds
      t.string :room_number

      t.timestamps
    end
  end
end
