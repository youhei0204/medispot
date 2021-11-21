class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.integer :sender_id
      t.string  :sender_name
      t.integer :request_type, null: false
      t.string  :subject
      t.integer :link_id
      t.boolean :new_flag, default: true, null: false
      t.references :user, foreign_key: true, index: true

      t.timestamps
    end
  end
end
