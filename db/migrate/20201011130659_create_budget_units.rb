class CreateBudgetUnits < ActiveRecord::Migration[5.2]
  def change
    create_table :budget_units do |t|
      t.string :type

      t.timestamps
    end
  end
end
