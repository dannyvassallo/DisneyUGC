class Api::V1::CampaignsController < ApplicationController

  def show
    @campaign = Campaign.friendly.find(params[:id])
    render json: @campaign
  end

end
