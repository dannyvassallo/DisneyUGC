class VideoUploader < CarrierWave::Uploader::Base
  
  include CarrierWave::Video
  storage :fog

  process encode_video: [:mp4]

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_white_list
    %w(ogg ogv 3gp mp4 m4v webm mov m2v 3g2)    
  end

end