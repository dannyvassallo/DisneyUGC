module CampaignsControllerHelper
  require "open-uri"
  require "uri"
  require "csv"

  if !Dir.exists?(Rails.root.join('tmp'))
    Dir.mkdir(Rails.root.join('tmp'))
  end

  def download_zip_of_all_posts(posts)
    count = 0
    number_of_posts = posts.count

    while count < number_of_posts
      posts.each do |post|
        # download images
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
        # create the csv
        if count === 1
          CSV.open("#{new_directory}/#{title}.csv", "wb") do |csv|
            csv << ["count", "filename", "email address", "full name"]
          end
        end
        # add lines to the csv
        CSV.open("#{new_directory}/#{title}.csv", "a+") do |csv|
          csv << [count, "#{count.to_s}-#{filename}", post.email_address, post.full_name]
        end
      end
    end

  end


end
