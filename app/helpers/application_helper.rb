module ApplicationHelper
  def user_admin(user)
    if user && user.role == 'admin'
      return true
    else
      return false
    end
  end
end
