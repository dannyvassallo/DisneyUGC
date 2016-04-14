class AddZipFileColumnToCampaigns < ActiveRecord::Migration
  def change
    add_column :campaigns, :zip_file, :string
  end
end
