class AddPostsForReviewToCampaigns < ActiveRecord::Migration
  def change
    add_column :campaigns, :posts_for_review, :text, array:true, default: []
  end
end
