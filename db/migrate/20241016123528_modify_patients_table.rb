class ModifyPatientsTable < ActiveRecord::Migration[7.1]
  def change
    rename_column :patients, :bloodgroup, :occupation
    remove_column :patients, :dob, :date
    add_column :patients, :age, :integer
  end
end
