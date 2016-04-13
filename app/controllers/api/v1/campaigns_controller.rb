class Api::V1::CampaignsController < ApplicationController
  include CampaignsControllerHelper

  def download_all_posts
    @campaign = Campaign.friendly.find(params[:campaign_id])
    @all_posts = @campaign.posts
    download_zip_of_all_posts(@all_posts)
    title = @campaign.title
    flash[:notice] = "All posts from '#{title}' were downloaded."
  end

end
