class AddNoTitleToCampaigns < ActiveRecord::Migration
  def change
    add_column :campaigns, :no_title, :boolean
  end
end
