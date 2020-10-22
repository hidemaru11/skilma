class ChangeRequestsToMates < ActiveRecord::Migration[5.2]
  def change
    rename_table :requests, :mates
  end
end
