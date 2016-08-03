class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :signed_in?, :current_user

  protected

  def signed_in?
    current_user.present?
  end

  def current_user
    User.last
  end
end
