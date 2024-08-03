class CreateDoctors < ActiveRecord::Migration[7.1]
  def change
    create_table :doctors do |t|
      t.string :name
      t.string :address
      t.bigint :phone_number
      t.string :role
      t.string :email
      t.string :password_digest
      t.string :plaintext_password
      t.string :specialist_in

      t.timestamps
    end
  end
end
