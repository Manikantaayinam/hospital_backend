class AddWardIdToBeds < ActiveRecord::Migration[7.1]
  def change
    add_column :beds, :ward_id, :integer
  end
end
