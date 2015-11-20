class AddTextShadowToCampaigns < ActiveRecord::Migration
  def change
    add_column :campaigns, :text_shadow, :string, :default => 'none'
  end
end
