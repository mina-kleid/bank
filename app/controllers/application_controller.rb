class ApplicationController < ActionController::Base
  protect_from_forgery

  def authenticate_user
    unless session[:users].present? && session[:users].eql?(@user)
      flash[:notice]="Please Login first"
      reset_session
      redirect_to root_path
    end
  end
end
