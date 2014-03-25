class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save

      redirect_to root_url, :notice => "Signed up!"
      session[:user_id] = @user.id
    else
      render "new"
    end
  end

  def update_notifications_date
    current_user.update_notifications_date
    redirect_to request.env["HTTP_REFERER"]
  end

  def edit

  end
end
