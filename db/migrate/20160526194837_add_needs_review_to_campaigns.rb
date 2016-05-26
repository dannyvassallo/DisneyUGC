class AddNeedsReviewToCampaigns < ActiveRecord::Migration
  def change
    add_column :campaigns, :needs_review, :boolean
  end
end
