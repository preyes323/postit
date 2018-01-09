class SessionsController < ApplicationController
  def new

  end

  def create

  end

  def destroy
    session[:user] = nil
    redirect_to root_path
  end
end
