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
        redirect_to campaigns_path
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
        redirect_to campaigns_path
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
    params.require(:campaign).permit(:title, :description, :call_to_action, :feature, :feature_cache, :video, :video_cache, :live, :slug, :analytics, :email_recipients, :email_notifications, :campaign_type)
  end

end
