class AddDeletedAtToReceptionists < ActiveRecord::Migration[7.1]
  def change
    add_column :receptionists, :deleted_at, :datetime
  end
end
