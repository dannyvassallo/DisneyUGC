module CampaignsControllerHelper
  require "open-uri"
  require "uri"

  if !Dir.exists?(Rails.root.join('tmp'))
    Dir.mkdir(Rails.root.join('tmp'))
  end

  def download_zip_of_all_posts(posts)
    count = 0
    posts.each do |post|
      title = post.campaign.title.split(' ').join('_')
      new_directory = 'tmp/' + title
      if !Dir.exists?(Rails.root.join(new_directory))
        Dir.mkdir(Rails.root.join(new_directory))
      end
      count+=1
      url = post.image_path
      url = URI.encode(url)
      uri = URI.parse(url)
      filename = File.basename(uri.path)
      open(url) {|f|
        File.open("#{new_directory}/#{count.to_s}-#{filename}","wb") do |file|
          file.puts f.read
        end
      }
    end
  end


end
