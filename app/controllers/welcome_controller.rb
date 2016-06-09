class WelcomeController < ApplicationController
  before_filter :require_login

	def index
    @user = current_user
    unless @user.admin?
      redirect_to limbo_path
    end
	end

  private

  def require_login
    unless current_user
      redirect_to login_url
    end
  end

end
