class ApplicationController < ActionController::Base

  before_action :authorize


  protected

  def authorize
    unless User.find_by(id: session[:user_id]) 
      redirect_to login_url, notice: "Please login"
    end
  end

  helper_method :current_user?
  
  def current_user?
    !!User.find_by(id: session[:user_id]) 
  end
end
