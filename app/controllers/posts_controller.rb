class PostsController < ApplicationController
  respond_to :html, :js
  include ApplicationHelper

  def get_posts
    @user = current_user    
    if user_admin(@user)    
      @campaign = Campaign.friendly.find(params[:campaign_id])
      @posts = @campaign.posts.order('created_at DESC')
      title = @campaign.title.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
      respond_to do |format|
        format.html
        format.csv { 
          send_data @posts.to_csv,
          :filename => "#{title}-entries-#{Date.today.to_s}"
        }
      end
    else
      not_found
    end
  end

  def random_winner  
    @campaign = Campaign.friendly.find(params[:campaign_id])
    @posts = @campaign.posts
    random_winner = @posts.order_by_rand.first
    random_winner_name = random_winner.full_name
    random_winner_email = random_winner.email_address
    flash[:notice] = "And the winner is... #{random_winner_name} | #{random_winner_email}!"            
    redirect_to @campaign
  end

  def slideshow
    @user = current_user    
    if user_admin(@user)    
      @campaign = Campaign.friendly.find(params[:campaign_id])
      @posts = @campaign.posts.order_by_rand
      render layout: "fullscreen-layout"
    else
      not_found
    end
  end  

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @campaign = Campaign.friendly.find(params[:campaign_id])
    @post = Post.new(post_params)    
    @post.campaign = @campaign

    if @post.save
      if @campaign.email_recipients != nil && @campaign.email_notifications == true
        UserMailer.notification_email(@post).deliver_now
      end
      flash[:notice] = "Your new post was created!"
      redirect_to @campaign
    else
      flash[:error] = "There was an error creating the post. Please try again."
      redirect_to @campaign
    end 
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])    

    if @post.update_attributes(post_params)
      flash[:notice] = "The post was updated!"
      redirect_to posts_path
    else
      flash[:error] = "There was an error updating the post. Please try again."
      render :edit
    end    
  end

  def destroy
    @user = current_user    
    if user_admin(@user)     
      @post = Post.find(params[:id])    
      @campaign = @post.campaign
      @post.destroy
      respond_to do |format|
        format.html { redirect_to campaign_path(@campaign) }
        format.json { head :no_content }
        format.js   { render :layout => false }
      end
    else
      not_found
    end
  end

  private

  def post_params
    params.require(:post).permit(:image_url, :video_url, :dob, :full_name, :email_address)
  end

end
