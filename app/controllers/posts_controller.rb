class PostsController < ApplicationController
  respond_to :html, :js
  include ApplicationHelper

  def index
    @posts = Post.all
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

      if @post.destroy
        flash[:notice] = "The post was deleted successfully."
        redirect_to @campaign
      else
        flash[:error] = "There was an error deleting the post. Please try again."
        redirect_to @campaign
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
