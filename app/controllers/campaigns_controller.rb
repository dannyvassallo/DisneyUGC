class CampaignsController < ApplicationController
  respond_to :html, :js

  def index
    @campaigns = Campaign.all
    authorize @campaigns
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
    @campaign = Campaign.new
    authorize @campaign
  end

  def create
    modified_params = feature_priority(campaign_params)
    @campaign = Campaign.new(modified_params)
    authorize @campaign
    title = @campaign.title

    if @campaign.save
      flash[:notice] = "Your new campaign '#{title}' was created!"
      redirect_to @campaign
    else
      flash[:error] = "There was an error creating the campaign. Please try again."
      render action: :new
    end
  end

  def edit
    @campaign = Campaign.friendly.find(params[:id])
    authorize @campaign
  end

  def update
    @campaign = Campaign.friendly.find(params[:id])
    authorize @campaign
    modified_params = feature_priority(campaign_params, @campaign)
    title = @campaign.title
    if @campaign.update_attributes(modified_params)
      flash[:notice] = "The campaign '#{title}' was updated!"
      redirect_to @campaign
    else
      flash[:error] = "There was an error updating the campaign. Please try again."
      render action: :edit
    end
  end

  def destroy
    @campaign = Campaign.friendly.find(params[:id])
    authorize @campaign
    title = @campaign.title

    if @campaign.destroy
      flash[:notice] = "The campaign '#{title}' was deleted successfully."
      redirect_to @campaign
    else
      flash[:error] = "There was an error deleting the campaign '#{title}'. Please try again."
      render :show
    end
  end

  def content_review
    @campaign = Campaign.friendly.find(params[:campaign_id])
    authorize @campaign
    @post_collection = @campaign.posts.paginate(page: params[:page], per_page: 16).order('created_at DESC')
    # @post_collection = @campaign.posts.order('created_at DESC').all
    respond_to do |format|
      format.html { render layout: 'content_review' }
      format.js
    end
  end

  def practices_review
    @campaign = Campaign.friendly.find(params[:campaign_id])
    authorize @campaign
    @post_collection = []
    @campaign.posts_for_review.each do |id|
      post = Post.find(id)
      @post_collection << post
    end
    @post_collection = @post_collection.paginate(page: params[:page], per_page: 16)
    # @post_collection = @campaign.posts.order('created_at DESC').all
    respond_to do |format|
      format.html { render layout: 'content_review' }
      format.js
    end
  end

  def approved_content
    @campaign = Campaign.friendly.find(params[:campaign_id])
    authorize @campaign
    @post_collection = []
    @campaign.approved_posts.each do |id|
      post = Post.find(id)
      @post_collection << post
    end
    @post_collection = @post_collection.paginate(page: params[:page], per_page: 16)
    # @post_collection = @campaign.posts.order('created_at DESC').all
    respond_to do |format|
      format.html { render layout: 'content_review' }
      format.js
    end
  end

  def practices_review_index
    @campaigns = Campaign.all.where("needs_review = 'true'")
    authorize @campaigns
    @approved_campaigns = Campaign.all.where("approved = 'true'")
    respond_to do |format|
      format.html { render layout: 'content_review' }
      format.js
    end
  end

  def download_all_posts
    @campaign = Campaign.friendly.find(params[:campaign_id])
    authorize @campaign
    @campaign.remove_zip_file = true
    @campaign.save!
    @all_posts = @campaign.posts.map(&:id)
    ZipCreator.delay.download_zip_of_all_posts(@all_posts, @campaign.id)
    render :nothing => true, :status => 200, :content_type => 'text/html'
  end

  def download_selected_posts
    @campaign = Campaign.friendly.find(params[:campaign_id])
    authorize @campaign
    selected_posts = params[:selected_posts].split(',').map(&:to_i)
    @campaign.remove_zip_file = true
    @campaign.save!
    ZipCreator.delay.download_zip_of_all_posts(selected_posts, @campaign.id)
    render :nothing => true, :status => 200, :content_type => 'text/html'
  end

  def posts_for_review
    @campaign = Campaign.friendly.find(params[:campaign_id])
    authorize @campaign
    selected_posts = params[:selected_posts_for_review].split(',').map(&:to_i)
    @campaign.update_attributes({
      :posts_for_review => selected_posts,
      :needs_review => true,
      :approved => false,
      :approved_posts => []
    })
    @campaign.save!
    redirect_to content_review_path
    flash[:notice] = "The items you've selected are now marked for review."
  end

  def approve_posts
    @campaign = Campaign.friendly.find(params[:campaign_id])
    authorize @campaign
    selected_posts = params[:approved_posts].split(',').map(&:to_i)
    @campaign.update_attributes({
      :approved_posts => selected_posts,
      :needs_review => false,
      :approved => true,
      :posts_for_review => []
    })
    @campaign.save!
    redirect_to practices_review_index_path
    flash[:notice] = "The items you've selected are now marked as approved."
  end

  def unmark_for_review
    @campaign = Campaign.friendly.find(params[:campaign_id])
    authorize @campaign
    @campaign.update_attributes({:needs_review => false})
    @campaign.save!
    redirect_to content_review_path
    flash[:notice] = "This selection has been removed from review."
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
      :needs_review,
      :approved,
      :approved_posts
      )
  end

end
