class AddProcessingToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :video_url_processing, :boolean, null: false, default: false
    add_column :posts, :image_url_processing, :boolean, null: false, default: false
  end
end
