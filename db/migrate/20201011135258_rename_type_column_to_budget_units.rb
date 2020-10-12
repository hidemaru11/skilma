class RenameTypeColumnToBudgetUnits < ActiveRecord::Migration[5.2]
  def change
    rename_column :budget_units, :type, :name
  end
end
