class SessionsController < ApplicationController
  def new
  end

  def create
    setup_identificators(User.find_or_create_by(name: params[:name]).id)
    redirect_to root_path
  end

  def destroy
    setup_identificators(nil)
    redirect_to root_path
  end
end
