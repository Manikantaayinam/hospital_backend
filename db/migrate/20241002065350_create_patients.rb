class CreatePatients < ActiveRecord::Migration[7.1]
  def change
    create_table :patients do |t|
      t.string :name
      t.date :dob
      t.string :gender
      t.string :bloodgroup
      t.string :email
      t.string :address
      t.bigint :phone_number
      t.string :role
      t.string :hospital_registration_id
      t.string :payment_status
      t.string :password_digest
      

      t.timestamps
    end
  end
end
