class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by username: params[:username]

    if user && user.authenticate(params[:password])
      flash[:notice] = "Welcome, you've logged in."
      session[:user] = user.id
      redirect_to root_path
    else
      flash[:error] = 'There is something wrong with your username or password.'
      render 'new'
    end
  end

  def destroy
    session[:user] = nil
    flash[:notice] = "You've logged out."
    redirect_to root_path
  end
end
