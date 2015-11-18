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
  before_save :double_attachment_check
  before_save :remove_photo, if: :video_changed?		
  before_save :remove_video, if: :image_changed?  

	def should_generate_new_friendly_id?
	  title_changed?
	end

  def normalize_friendly_id(string)
		super.gsub("-", "")		
	end

	def remove_photo
		self.remove_feature!
	end

	def remove_video
		self.remove_video!
	end

	def video_changed?
		return self.video.cached?.present?
	end

	def image_changed?
		return self.feature.cached?.present?
	end

	def double_attachment_check		
		if self.feature.cached?.present? && self.video.cached?.present?
			return false
		end
	end	

end