module CampaignsControllerHelper
  # deps for downloading files
  require "open-uri"
  require "uri"
  # dep for csz
  require "csv"
  # dep for zip
  require "zip"
  # dep for directory manipulation
  require "fileutils"

  # if no temp folder, make one
  if !Dir.exists?(Rails.root.join('tmp'))
    Dir.mkdir(Rails.root.join('tmp'))
  end

  # method definition
  def download_zip_of_all_posts(posts)
    count = 0
    number_of_posts = posts.count
    @new_directory

    # runs while count is < total number of entries
    while count < number_of_posts
      posts.each do |post|
        # download images
        title = post.campaign.title.split(' ').join('_')
        @new_directory = 'tmp/' + title
        # if directory doesnt exist create it
        if !Dir.exists?(Rails.root.join(@new_directory))
          Dir.mkdir(Rails.root.join(@new_directory))
        end
        # increment count and add photo to new directory
        count+=1
        url = post.image_path
        url = URI.encode(url)
        uri = URI.parse(url)
        filename = File.basename(uri.path)
        open(url) {|f|
          File.open("#{@new_directory}/#{count.to_s}-#{filename}","wb") do |file|
            file.puts f.read
          end
        }
        # create the csv
        if count === 1
          CSV.open("#{@new_directory}/#{title}.csv", "wb") do |csv|
            csv << ["count", "filename", "email address", "full name"]
          end
        end
        # add lines to the csv for each image
        CSV.open("#{@new_directory}/#{title}.csv", "a+") do |csv|
          csv << [count, "#{count.to_s}-#{filename}", post.email_address, post.full_name]
        end
      end
    end

    # when the count is the number of posts, zip that stuff up
    if count === number_of_posts
      path = @new_directory
      path.sub!(%r[/$],'')
      archive = File.join(path,File.basename(path))+'.zip'
      FileUtils.rm archive, :force=>true

      Zip::File.open(archive, 'w') do |zipfile|
        Dir["#{path}/**/**"].reject{|f|f==archive}.each do |file|
          zipfile.add(file.sub(path+'/',''),file)
        end
      end

      # open the file to send it to the user
      File.open(archive, 'r') do |f|
        zip_data = File.read("#{archive}")
        send_data(zip_data, :type => 'application/zip', :filename => "#{File.basename(path)}.zip")
      end
      # delete the entire directory when the download is sent
      FileUtils.rm_rf(@new_directory)
    end

  end


end
