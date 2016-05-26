class CampaignsController < ApplicationController
  respond_to :html, :js
  include ApplicationHelper

  def index
    @user = current_user
    if user_admin(@user)
      @campaigns = Campaign.all
    else
      not_found
    end
  end

  def show
    @campaign = Campaign.friendly.find(params[:id])
    @duration_limit = Time.at(@campaign.duration_limit).utc.strftime("%M:%S")
    @user = current_user
    unless @campaign.live
      unless user_admin(@user)
        not_found
      end
    end
    if params[:search]
      @posts = @campaign.posts.search(params[:search]).paginate(:page => params[:page], :per_page => 12).order('created_at DESC')
    else
      @posts = @campaign.posts.paginate(:page => params[:page], :per_page => 12).order('created_at DESC')
    end
  end

  def new
    @user = current_user
    if user_admin(@user)
      @campaign = Campaign.new
    else
      not_found
    end
  end

  def create
    @user = current_user
    if user_admin(@user)
      modified_params = feature_priority(campaign_params)
      @campaign = Campaign.new(modified_params)
      title = @campaign.title

      if @campaign.save
        flash[:notice] = "Your new campaign '#{title}' was created!"
        redirect_to @campaign
      else
        flash[:error] = "There was an error creating the campaign. Please try again."
        render action: :new
      end
    else
      not_found
    end
  end

  def edit
    @user = current_user
    if user_admin(@user)
      @campaign = Campaign.friendly.find(params[:id])
    else
      not_found
    end
  end

  def update
    @user = current_user
    if user_admin(@user)
      @campaign = Campaign.friendly.find(params[:id])
      modified_params = feature_priority(campaign_params, @campaign)
      title = @campaign.title
      if @campaign.update_attributes(modified_params)
        flash[:notice] = "The campaign '#{title}' was updated!"
        redirect_to @campaign
      else
        flash[:error] = "There was an error updating the campaign. Please try again."
        render action: :edit
      end
    else
      not_found
    end
  end

  def destroy
    @user = current_user
    if user_admin(@user)
      @campaign = Campaign.friendly.find(params[:id])
      title = @campaign.title

      if @campaign.destroy
        flash[:notice] = "The campaign '#{title}' was deleted successfully."
        redirect_to @campaign
      else
        flash[:error] = "There was an error deleting the campaign '#{title}'. Please try again."
        render :show
      end
    else
      not_found
    end
  end

  def content_review
    @user = current_user
    if user_admin(@user)
      @campaign = Campaign.friendly.find(params[:campaign_id])
      @post_collection = @campaign.posts.paginate(page: params[:page], per_page: 16).order('created_at DESC')
      # @post_collection = @campaign.posts.order('created_at DESC').all
      respond_to do |format|
        format.html { render layout: 'content_review' }
        format.js
      end
    else
      not_found
    end
  end

  def download_all_posts
    @user = current_user
    if user_admin(@user)
      @campaign = Campaign.friendly.find(params[:campaign_id])
      @campaign.remove_zip_file = true
      @campaign.save!
      @all_posts = @campaign.posts.map(&:id)
      ZipCreator.delay.download_zip_of_all_posts(@all_posts, @campaign.id)
      render :nothing => true, :status => 200, :content_type => 'text/html'
    else
      not_found
    end
  end

  def download_selected_posts
    @user = current_user
    if user_admin(@user)
      @campaign = Campaign.friendly.find(params[:campaign_id])
      selected_posts = params[:selected_posts].split(',').map(&:to_i)
      @campaign.remove_zip_file = true
      @campaign.save!
      ZipCreator.delay.download_zip_of_all_posts(selected_posts, @campaign.id)
      render :nothing => true, :status => 200, :content_type => 'text/html'
    else
      not_found
    end
  end

  def posts_for_review
    @user = current_user
    if user_admin(@user)
      @campaign = Campaign.friendly.find(params[:campaign_id])
      selected_posts = params[:selected_posts_for_review].split(',').map(&:to_i)
      @campaign.update_attributes({:posts_for_review => selected_posts, :needs_review => true})
      @campaign.save!
      redirect_to content_review_path
      flash[:notice] = "The items you've selected are now marked for review."
    else
      not_found
    end
  end

  private

  def feature_priority(modified_params, campaign = nil)
    modified_params = modified_params.dup
    if modified_params['video']
      campaign.remove_feature! unless campaign.nil?
      modified_params.delete('feature')
      modified_params.delete('feature_cache')
    elsif modified_params['feature']
      campaign.remove_video! unless campaign.nil?
      modified_params.delete('video')
      modified_params.delete('video_cache')
    end
    return modified_params
  end

  def campaign_params
    params.require(:campaign).permit(:title,
      :description,
      :call_to_action,
      :feature,
      :feature_cache,
      :video,
      :video_cache,
      :live,
      :slug,
      :analytics,
      :email_recipients,
      :email_notifications,
      :campaign_type,
      :duration_limit,
      :entries_visible,
      :top_color,
      :bottom_color,
      :text_color,
      :text_shadow,
      :no_title,
      :posts_for_review,
      :needs_review)
  end

end
