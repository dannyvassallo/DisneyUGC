class Campaign < ActiveRecord::Base
	has_many :posts
	extend FriendlyId
	friendly_id :title, use: :slugged
	mount_uploader :feature, FeatureUploader
	process_in_background :feature
	mount_uploader :video, VideoUploader	 
	process_in_background :video
	validates_presence_of :title
	validates_presence_of :description
	validates_presence_of :call_to_action

	def should_generate_new_friendly_id?
	  title_changed?
	end
end
