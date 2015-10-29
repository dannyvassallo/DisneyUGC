module ApplicationHelper
  
  def user_admin(user)
    if user && user.role == 'admin'
      return true
    else
      return false
    end
  end

  def not_found
    render 'campaigns/_error', :status => '404'
  end

end
