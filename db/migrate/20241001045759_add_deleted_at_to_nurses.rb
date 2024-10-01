class AddDeletedAtToNurses < ActiveRecord::Migration[7.1]
  def change
    add_column :nurses, :deleted_at, :datetime
  end
end
