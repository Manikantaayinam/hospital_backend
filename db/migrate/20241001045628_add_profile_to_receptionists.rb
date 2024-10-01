class AddProfileToReceptionists < ActiveRecord::Migration[7.1]
  def change
    add_column :receptionists, :profile, :text
  end
end
