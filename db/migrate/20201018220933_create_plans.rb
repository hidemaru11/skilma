class CreatePlans < ActiveRecord::Migration[5.2]
  def change
    create_table :plans do |t|
      t.string :title, null: false
      t.text :content, null: false
      t.integer :budget
      t.references :skill, foreign_key: true
      t.references :budget_unit, foreign_key: true

      t.timestamps
    end
  end
end
