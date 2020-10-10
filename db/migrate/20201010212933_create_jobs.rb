class CreateJobs < ActiveRecord::Migration[5.2]
  def change
    create_table :jobs do |t|
      t.string :title, null: false
      t.text :content, null: false
      t.string :area
      t.integer :budget
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
