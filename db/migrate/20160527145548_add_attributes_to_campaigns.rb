class AddAttributesToCampaigns < ActiveRecord::Migration
  def change
    add_column :campaigns, :approved, :boolean
    add_column :campaigns, :approved_posts, :text, array:true, default: []
  end
end
