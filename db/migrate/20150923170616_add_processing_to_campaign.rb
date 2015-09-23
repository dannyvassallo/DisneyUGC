class AddProcessingToCampaign < ActiveRecord::Migration
  def change
    add_column :campaigns, :feature_processing, :boolean, null: false, default: false
    add_column :campaigns, :video_processing, :boolean, null: false, default: false
  end
end
