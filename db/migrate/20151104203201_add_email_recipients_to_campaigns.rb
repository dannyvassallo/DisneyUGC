class AddEmailRecipientsToCampaigns < ActiveRecord::Migration
  def change
    add_column :campaigns, :email_recipients, :string
  end
end
