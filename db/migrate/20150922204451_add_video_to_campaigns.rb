class AddVideoToCampaigns < ActiveRecord::Migration
  def change
    add_column :campaigns, :video, :string
  end
end
