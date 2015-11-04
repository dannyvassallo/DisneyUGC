class AddAnalyticsToCampaigns < ActiveRecord::Migration
  def change
    add_column :campaigns, :analytics, :string
  end
end
