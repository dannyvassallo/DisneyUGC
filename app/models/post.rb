require 'streamio-ffmpeg'
require 'mini_magick'

class Post < ActiveRecord::Base
  # server side validation
  validates_presence_of :full_name
  validates_presence_of :email_address
  validates_presence_of :dob
  validate :image_or_video
  validate :video
  validate :age

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

  #validates length
  def video
    if !video_url.blank?
      movie = FFMPEG::Movie.new(self.video_url.path)
      duration = movie.duration
      duration_limit = self.campaign.duration_limit
      if duration > duration_limit
        errors.add(:video_url, "Video must not be longer than #{duration_limit}")
      end
    end
  end

  # age
  def age
    if dob.blank?
      errors.add(:dob, "Can't be blank.")
    else
      user_age = (Time.now.to_s(:number).to_i - dob.to_time.to_s(:number).to_i)/10e9.to_i
      if user_age < 13
        errors.add(:dob, "Sorry, you aren't old enough to use this site.")
      end
    end
  end

  # to csv
  def self.to_csv
    attributes = %w{created_at full_name email_address image_path video_path}

    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |post|
        csv << attributes.map{ |attr| post.send(attr) }
      end
    end
  end

  def image_path
    self.image_url.url
  end

  def video_path
    self.video_url.url
  end

  def self.search(search)
    where("(full_name || ' ' || email_address) LIKE ?", "%#{search.downcase}%")
  end


end
