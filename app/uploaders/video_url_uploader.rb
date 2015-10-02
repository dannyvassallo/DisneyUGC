require 'rubygems'
require 'streamio-ffmpeg'

class Video_urlUploader < CarrierWave::Uploader::Base
  
	include CarrierWave::Video	
	include CarrierWave::Video::Thumbnailer
	include ::CarrierWave::Backgrounder::Delay

	storage :fog

	process :encode_video=> [:mp4, audio_codec: "aac",:custom => "-strict experimental -q:v 5 -preset slow -g 30"]

	version :thumb do
		process thumbnail: [{format: 'png', quality: 10, size: 250, strip: false, square: true, logger: Rails.logger}]
		def full_filename for_file
			png_name for_file, version_name
		end
	end

	def png_name for_file, version_name
		%Q{#{version_name}_#{for_file.chomp(File.extname(for_file))}.png}
	end

	# Override the directory where uploaded files will be stored.
	# This is a sensible default for uploaders that are meant to be mounted:
	def store_dir
		"uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
	end

	def extension_white_list
		%w(ogg ogv 3gp mp4 m4v webm mov m2v 3g2)    
	end

end