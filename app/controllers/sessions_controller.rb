class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by username: params[:username]

    if user && user.authenticate(params[:password])
      if user.two_factor_auth?
        session[:two_factor] = true
        user.generate_pin!
        user.send_sms_to_twilio
        redirect_to pin_path
      else
        flash[:notice] = "Welcome, you've logged in."
        session[:user] = user.id
        redirect_to root_path
      end
    else
      flash.now[:error] = 'There is something wrong with your username or password.'
      render 'new'
    end
  end

  def destroy
    session[:user] = nil
    session[:two_factor] = nil
    flash[:notice] = "You've logged out."
    redirect_to root_path
  end

  def pin
    not_allowed if session[:two_factor].nil?

    if request.post?
      user = User.find_by pin: params[:pin]
      if user
        session[:two_factor] = nil
        user.remove_pin!
        flash[:notice] = "Welcome, you've logged in."
        session[:user] = user.id
        redirect_to root_path
      else
        flash[:error] = "Sorry, something is wrong with your pin."
        redirect_to pin_path
      end
    end
  end
end
