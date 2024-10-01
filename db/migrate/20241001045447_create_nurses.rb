class CreateNurses < ActiveRecord::Migration[7.1]
  def change
    create_table :nurses do |t|
      t.string :name
      t.string :address
      t.bigint :phone_number
      t.string :email
      t.string :hospital_registration_id
      t.text :profile
      t.string :role

      t.timestamps
    end
  end
end
