class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  def authentication_required
    redirect_to root_path if session[:user_id].nil?
  end

  def current_user
    User.find_by(:id => session[:user_id]) unless session[:user_id].nil?
  end

end
