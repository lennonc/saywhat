class SessionsController < ApplicationController
  def new
  end

  def create
    # user = User.authenticate(params[:email], params[:password])
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    redirect_to root_url

    # if user
    #   session[:user] = user
    #   redirect_to root_url, :notice => "Logged In!"
    # else
    #   session[:user] = nil
    #   flash.now.alert = "Invalid email or password"
    #   render "new"
    # end
  end

  def destroy
    session[:user_id] = nil
    redirect_to log_in_path, :notice => "Logged out!"
  end
end
