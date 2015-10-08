class Post < ActiveRecord::Base
	# server side validation	
	validates_presence_of :full_name
	validates_presence_of :email_address
	validates_presence_of :dob
	validate :image_or_video

    #other properties 
	belongs_to :campaign
	mount_uploader :image_url, Image_urlUploader
	process_in_background :image_url	
	mount_uploader :video_url, Video_urlUploader
	process_in_background :video_url	

	# image or video
	def image_or_video
		if image_url.blank? && video_url.blank?
			errors.add(:image_url, "Can't be blank")
			errors.add(:video_url, "Can't be blank")
		end
	end
end
