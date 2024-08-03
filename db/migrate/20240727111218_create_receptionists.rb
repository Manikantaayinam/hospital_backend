class CreateReceptionists < ActiveRecord::Migration[7.1]
  def change
    create_table :receptionists do |t|
      t.string :name
      t.string :address
      t.bigint :phone_number
      t.string :role
      t.string :email
      t.string :password_digest
      t.string :plaintext_password

      t.timestamps
    end
  end
end
