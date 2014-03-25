class AddTimeOpenedNotificationToUser < ActiveRecord::Migration
  def change
    add_column :users, :time_opened_notification, :datetime
  end
end
