class AddBudgetUnitIdToJobs < ActiveRecord::Migration[5.2]
  def change
    add_reference :jobs, :budget_unit, foreign_key: true
  end
end
