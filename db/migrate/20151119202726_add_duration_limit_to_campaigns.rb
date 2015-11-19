class AddDurationLimitToCampaigns < ActiveRecord::Migration
  def change
    add_column :campaigns, :duration_limit, :integer, :default => 15
  end
end
