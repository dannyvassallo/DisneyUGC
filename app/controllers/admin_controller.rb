class AdminController < ApplicationController
  respond_to :html, :js
  include ApplicationHelper

  def index
    @user = current_user    
    if user_admin(@user)
      @users = User.all
    else
      not_found
    end        
  end

end
