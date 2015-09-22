class AddFeatureToCampaigns < ActiveRecord::Migration
  def change
    add_column :campaigns, :feature, :string
  end
end
