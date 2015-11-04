class AddEmailNotificationsToCampaigns < ActiveRecord::Migration
  def change
    add_column :campaigns, :email_notifications, :boolean, default: false
  end
end
