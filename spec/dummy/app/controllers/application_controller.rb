class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :signed_in?, :current_user

  protected

  def signed_in?
    current_user.present?
  end

  def current_user
    return unless session[:user_id]
    @current_user ||= User.find_by_id(cookies.signed[:user_id]).tap do |user|
      setup_identificators(nil) if user.nil?
    end
  end

  private

  def setup_identificators(value)
    cookies.signed[:user_id] = value
    session[:user_id] = value
  end
end
