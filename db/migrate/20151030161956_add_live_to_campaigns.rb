class AddLiveToCampaigns < ActiveRecord::Migration
  def change
    add_column :campaigns, :live, :boolean, default: false
  end
end
