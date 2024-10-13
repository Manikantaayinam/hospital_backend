class CreateBeds < ActiveRecord::Migration[7.1]
  def change
    create_table :beds do |t|
      t.string :bed_number
      t.string :bed_type
      t.string :status
      t.datetime :entryDate
      t.datetime :exitDate

      t.timestamps
    end
  end
end
