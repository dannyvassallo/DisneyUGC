require 'rails_helper'

describe PostsController do

  include TestFactories  
  include Devise::TestHelpers

  before do  
    @campaign = create(:campaign)    
    @campaign.save!    
  end

  describe '#create' do
    it "Of age anon attempts to create a post with just a photo" do
      # create post      
      post :create, campaign_id: @campaign.slug, post:{        
        full_name: Faker::Name.name,
        dob: "22 November, 1967",
        email_address: Faker::Internet.email,
        image_url: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/fixtures/files/rails.png'))),            
        video_url: nil,
        video_url_processing: false,
        image_url_processing: false
      }
      @post = Post.last            
      expect(@post.campaign.title).to eq(@campaign.title)
      expect(Post.count).to eq(1)
      print("\nAnon created post with just a photo")
    end 

    it "underage anon attempts to create a post with just a photo and fails" do
      # create post      
      post :create, campaign_id: @campaign.slug, post:{        
        full_name: Faker::Name.name,
        dob: "22 November, 2003",
        email_address: Faker::Internet.email,
        image_url: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/fixtures/files/rails.png'))),            
        video_url: nil,
        video_url_processing: false,
        image_url_processing: false
      }
      @post = Post.last            
      expect(Post.count).to eq(0)
      print("\nAnon couldn't create post with just a photo")
    end 

    it "Of age anon attempts to create a post with just a video" do
      # create post      
      post :create, campaign_id: @campaign.slug, post:{        
        full_name: Faker::Name.name,
        dob: "22 November, 1967",
        email_address: Faker::Internet.email,
        image_url: nil,            
        video_url: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/fixtures/files/8450DACAD21274209265779081216_SW_WEBM_1446769221867227cf9729c.mp4'))),
        video_url_processing: false,
        image_url_processing: false
      }
      @post = Post.last            
      expect(@post.campaign.title).to eq(@campaign.title)
      expect(Post.count).to eq(1)
      print("\nAnon created post with just a photo")
    end 

    it "underage anon attempts to create a post with just a video and fails" do
      # create post      
      post :create, campaign_id: @campaign.slug, post:{        
        full_name: Faker::Name.name,
        dob: "22 November, 2003",
        email_address: Faker::Internet.email,
        image_url: nil,
        video_url: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/fixtures/files/8450DACAD21274209265779081216_SW_WEBM_1446769221867227cf9729c.mp4'))),
        video_url_processing: false,
        image_url_processing: false
      }
      @post = Post.last            
      expect(Post.count).to eq(0)
      print("\nAnon couldn't create post with just a photo")
    end 

  end

  describe '#destroy' do

    before do
      @user = create(:user)    
      @user.save!       
      sign_in @user
      post :create, campaign_id: @campaign.slug, post:{        
        full_name: Faker::Name.name,
        dob: "22 November, 1967",
        email_address: Faker::Internet.email,
        image_url: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/fixtures/files/rails.png'))),            
        video_url: nil,
        video_url_processing: false,
        image_url_processing: false
      }            
    end

    it "attempts destroy a new post as Admin" do
      @post = Post.last
      expect(Post.count).to eq(1)
      @user.update_attributes(:role => 'admin')
      @user.save!       
      delete :destroy, campaign_id: @campaign.slug, id: @post.id
      expect(Post.count).to eq(0)
      print("\nAdmin deleted a post")
    end

    it "attempts destroy a new post as Non-Admin" do
      @post = Post.last
      expect(Post.count).to eq(1)     
      delete :destroy, campaign_id: @campaign.slug, id: @post.id
      expect(Post.count).to eq(1)
      print("\nNon-Admin couldn't delete a post")
    end

    it "attempts destroy a new post as Anon" do
      sign_out @user
      @post = Post.last
      expect(Post.count).to eq(1)     
      delete :destroy, campaign_id: @campaign.slug, id: @post.id
      expect(Post.count).to eq(1)
      print("\nAnon couldn't delete a post")
    end

  end

end