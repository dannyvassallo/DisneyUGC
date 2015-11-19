class AddEntriesVisibleToCampaigns < ActiveRecord::Migration
  def change
    add_column :campaigns, :entries_visible, :boolean, :default => true
  end
end
