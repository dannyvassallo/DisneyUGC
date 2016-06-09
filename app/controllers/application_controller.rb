class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include Pundit
  include ApplicationHelper
  protect_from_forgery with: :exception
  require 'will_paginate/array'

  rescue_from Pundit::NotAuthorizedError do |exception|
    not_found
  end

end
