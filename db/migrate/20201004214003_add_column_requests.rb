class AddColumnRequests < ActiveRecord::Migration[5.2]
  def up
    add_column :requests, :area, :string
  end

  def down
    remove_column :requests, :budget, :integer
  end
end
