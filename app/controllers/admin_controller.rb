class AdminController < ApplicationController
  respond_to :html, :js

  def index
    results_per_page = 20
    @users = User.all.paginate(:page => params[:page], :per_page => results_per_page).order('created_at DESC')
    authorize @users
    if params[:search]
      @users = User.search(params[:search]).paginate(:page => params[:page], :per_page => results_per_page).order('created_at DESC')
    else
      @users = User.all.order("created_at DESC").paginate(:page => params[:page], :per_page => results_per_page).order('created_at DESC')
    end
  end

end
