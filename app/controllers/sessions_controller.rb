class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(cip: params[:session][:cip])
    if user && user.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_back_or user
    else
      flash.now[:danger] = 'Invalid cip/password combination'
      render'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
