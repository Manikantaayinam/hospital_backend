class CreatePayments < ActiveRecord::Migration[7.1]
  def change
    create_table :payments do |t|
      t.integer :patient_id
      t.integer :appointment_id
      t.decimal :total_amount
      t.string :payment_status
      t.decimal :due_amount
      t.decimal :paid_amount

      t.timestamps
    end
  end
end
