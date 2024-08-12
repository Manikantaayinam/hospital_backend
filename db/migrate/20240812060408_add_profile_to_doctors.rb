class AddProfileToDoctors < ActiveRecord::Migration[7.1]
  def change
    add_column :doctors, :profile, :text
  end
end
