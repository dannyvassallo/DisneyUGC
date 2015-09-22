class Campaign < ActiveRecord::Base

	extend FriendlyId
	friendly_id :title, use: :slugged
	mount_uploader :feature, FeatureUploader
	mount_uploader :video, VideoUploader	 

end
