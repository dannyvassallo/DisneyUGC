class WelcomeController < ApplicationController
  before_filter :require_login

	def index
    @user = current_user
    unless @user.admin?
      if !@user.reviewer?
        redirect_to limbo_path
      elsif @user.reviewer?
        redirect_to practices_review_index_path
      end
    end
	end

  private

  def require_login
    unless current_user
      redirect_to login_url
    end
  end

end
