class AddStatusToDoctors < ActiveRecord::Migration[7.1]
  def change
    add_column :doctors, :status, :string
    add_column :nurses, :status, :string
    add_column :receptionists, :status, :string
  end
end
