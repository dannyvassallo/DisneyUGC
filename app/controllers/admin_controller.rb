class AdminController < ApplicationController
  respond_to :html, :js
  include ApplicationHelper

  def index
    @users = User.all
  end

end
