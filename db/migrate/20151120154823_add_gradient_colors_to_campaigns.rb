class AddGradientColorsToCampaigns < ActiveRecord::Migration
  def change
    add_column :campaigns, :top_color, :string, :default => '#ffffff'
    add_column :campaigns, :bottom_color, :string, :default => '#ffffff'
  end
end
