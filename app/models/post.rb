class Post < ActiveRecord::Base
	belongs_to :campaign
	mount_uploader :image_url, Image_urlUploader
	process_in_background :image_url	
	mount_uploader :video_url, Video_urlUploader
	process_in_background :video_url	
end
