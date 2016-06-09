module ApplicationHelper

  def not_found
    render 'campaigns/_error', :status => '404'
  end

end
