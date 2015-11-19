class AdminController < ApplicationController
  respond_to :html, :js
  include ApplicationHelper

  def index
    @user = current_user
    results_per_page = 20
    if user_admin(@user)
      @users = User.all.paginate(:page => params[:page], :per_page => results_per_page).order('created_at DESC')
      if params[:search]
        @users = User.search(params[:search]).paginate(:page => params[:page], :per_page => results_per_page).order('created_at DESC')
      else
        @users = User.all.order("created_at DESC").paginate(:page => params[:page], :per_page => results_per_page).order('created_at DESC')
      end
    else
      not_found
    end
  end

end
