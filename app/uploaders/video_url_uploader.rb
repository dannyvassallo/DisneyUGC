require 'rubygems'
require 'streamio-ffmpeg'
require 'mime/types'


class Video_urlUploader < CarrierWave::Uploader::Base

  include CarrierWave::Video
  include CarrierWave::Video::Thumbnailer
  include ::CarrierWave::Backgrounder::Delay
  include CarrierWave::MiniMagick
  include CarrierWave::MimeTypes

  storage :fog

  process :encode_video=> [:mp4, audio_codec: "aac",:custom => "-strict experimental -q:v 5 -preset slow -g 30"]

  version :thumb do

    process thumbnail: [{format: 'png', quality: 10, size: 320, strip: false, logger: Rails.logger}]
    process :convert => 'png'
    process :set_content_type
    process resize_to_fill: [320, 320]

    def full_filename for_file
      png_name for_file, version_name
    end

    def png_name for_file, version_name
      %Q{#{version_name}_#{for_file.chomp(File.extname(for_file))}.png}
    end

  end

  version :poster do

    process thumbnail: [{format: 'jpg', quality: 7, size: 640, strip: false, logger: Rails.logger}]
    process :convert => 'jpg'
    process :set_content_type
    process resize_to_fill: [640, 640]

    def full_filename for_file
      jpg_name for_file, version_name
    end

    def jpg_name for_file, version_name
      %Q{#{version_name}_#{for_file.chomp(File.extname(for_file))}.jpg}
    end

  end

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_white_list
    %w(ogg ogv 3gp mp4 m4v webm mov m2v 3g2)
  end

  def set_content_type(*args)
    content_type = file.content_type == 'application/octet-stream' || file.content_type.blank? ? MIME::Types.type_for(original_filename).first : file.content_type

    self.file.instance_variable_set(:@content_type, content_type)
  end

  def assets_host
   ENV['CLOUDFRONT_DOMAIN']
  end

end
