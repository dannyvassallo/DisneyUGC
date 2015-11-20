class AddTextColorToCampaigns < ActiveRecord::Migration
  def change
    add_column :campaigns, :text_color, :string, :default => '#000000'
  end
end
