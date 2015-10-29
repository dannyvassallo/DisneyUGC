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
    @posts = @campaign.posts.paginate(:page => params[:page], :per_page => 12).order('created_at DESC')
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
      @campaign = Campaign.new(campaign_params)
      title = @campaign.title

      if @campaign.save
        flash[:notice] = "Your new campaign '#{title}' was created!"
        redirect_to campaigns_path
      else
        flash[:error] = "There was an error creating the campaign. Please try again."
        render :new
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
      title = @campaign.title

      if @campaign.update_attributes(campaign_params)
        flash[:notice] = "The campaign '#{title}' was updated!"
        redirect_to campaigns_path
      else
        flash[:error] = "There was an error updating the campaign. Please try again."
        render :edit
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
    end
  end

  private

  def campaign_params
    params.require(:campaign).permit(:title, :description, :call_to_action, :feature,:feature_cache, :video, :video_cache)
  end

end
