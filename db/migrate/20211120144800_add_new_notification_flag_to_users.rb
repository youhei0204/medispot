class AddNewNotificationFlagToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :new_notification_flag, :boolean, default: false, null: false
  end
end
