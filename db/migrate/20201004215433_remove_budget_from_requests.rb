class RemoveBudgetFromRequests < ActiveRecord::Migration[5.2]
  def change
    remove_column :requests, :budget, :integer
  end
end
