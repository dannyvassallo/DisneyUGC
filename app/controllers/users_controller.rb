class UsersController < ApplicationController
  respond_to :html, :js


  def edit
    @post = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    authorize @user
    if params[:user][:password].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end
    if @user.update_attributes(user_params)
      if @user.role == 'admin'
        flash[:notice] = "#{@user.email} was granted privileges!"
        redirect_to admin_index_path
      else
        flash[:notice] = "#{@user.email}'s privileges were revoked!"
        redirect_to admin_index_path
      end
    else
      flash[:error] = "There was an error updating the user. Please try again."
      redirect_to admin_index_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:role)
  end

end
