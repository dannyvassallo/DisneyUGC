class CampaignsController < ApplicationController
  respond_to :html, :js

  def index
    @campaigns = Campaign.all
  end

  def show
    @campaign = Campaign.friendly.find(params[:id])
  end

  def new
    @campaign = Campaign.new
  end

  def create
    @campaign = Campaign.new(campaign_params)
    title = @campaign.title

    if @campaign.save
      flash[:notice] = "Your new campaign '#{title}' was created!"
      redirect_to campaigns_path
    else
      flash[:error] = "There was an error creating the campaign. Please try again."
      render :new
    end 
  end

  def edit
    @campaign = Campaign.friendly.find(params[:id])
  end

  def update
    @campaign = Campaign.friendly.find(params[:id])
    title = @campaign.title

    if @campaign.update_attributes(campaign_params)
      flash[:notice] = "The campaign '#{title}' was updated!"
      redirect_to campaigns_path
    else
      flash[:error] = "There was an error updating the campaign. Please try again."
      render :edit
    end    
  end

  def destroy
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

  private

  def campaign_params
    params.require(:campaign).permit(:title, :description, :call_to_action, :feature,:feature_cache, :video, :video_cache)
  end

end
