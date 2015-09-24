class PostsController < ApplicationController
  respond_to :html, :js

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
    @post = Post.new(post_params)    

    if @post.save
      flash[:notice] = "Your new post was created!"
      redirect_to posts_path
    else
      flash[:error] = "There was an error creating the post. Please try again."
      render :new
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
    @post = Post.find(params[:id])    

    if @post.destroy
      flash[:notice] = "The post was deleted successfully."
      redirect_to @post
    else
      flash[:error] = "There was an error deleting the post. Please try again."
      render :show
    end    
  end

  private

  def post_params
    params.require(:post).permit(:image_url, :video_url)
  end

end
