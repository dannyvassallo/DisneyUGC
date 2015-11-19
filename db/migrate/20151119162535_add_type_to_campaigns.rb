class AddTypeToCampaigns < ActiveRecord::Migration
  def change
    add_column :campaigns, :campaign_type, :string, :default => "Both Media Types"
  end
end
