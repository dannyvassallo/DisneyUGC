class Api::V1::PostsController < ApplicationController

  def show
    @campaign = Campaign.friendly.find(params[:campaign_id])
    @post = @campaign.posts.find(params[:id])
    respond_to do |format|
      format.json { render :json => @post }
    end
  end

end