class SessionsController < ApplicationController
  #before_filter :authenticate_user

  def create
    user = User.authenticate(params[:email],params[:password])
    if user
      session[:users] = user
      redirect_to user_path(:id => user.id)
    else
      flash[:error] = 'Invalid email/password combination' # Not quite right!
      redirect_to root_path
    end
  end

  def destroy
    reset_session
    redirect_to root_path
  end
end
