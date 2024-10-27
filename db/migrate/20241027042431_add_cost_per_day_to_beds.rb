class AddCostPerDayToBeds < ActiveRecord::Migration[7.1]
  def change
    add_column :beds, :cost_per_day, :decimal
  end
end
