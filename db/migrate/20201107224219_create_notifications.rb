class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.integer :visitor_id, foreign_key: { to_table: :users }, null: false
      t.integer :visited_id, foreign_key: { to_table: :users }, null: false
      t.integer :room_id, foreign_key: true
      t.integer :message_id, foreign_key: true
      t.string :action, default: '', null: false
      t.boolean :checked, default: false, null: false

      t.timestamps
    end

    add_index :notifications, :visitor_id
    add_index :notifications, :visited_id
    add_index :notifications, :room_id
    add_index :notifications, :message_id
  end
end
