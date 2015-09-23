class Campaign < ActiveRecord::Base

	extend FriendlyId
	friendly_id :title, use: :slugged
	mount_uploader :feature, FeatureUploader
	process_in_background :feature
	mount_uploader :video, VideoUploader	 
	process_in_background :video

end
