class LimboController < ApplicationController

  def index
    @user = current_user
    if @user.admin?
      redirect_to root_url
    elsif @user.reviewer?
      redirect_to practices_review_index_path
    end
  end

end
