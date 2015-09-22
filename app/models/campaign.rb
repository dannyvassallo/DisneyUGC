class Campaign < ActiveRecord::Base
	extend FriendlyId
	friendly_id :title, use: :slugged
	mount_uploader :feature, FeatureUploader
end
