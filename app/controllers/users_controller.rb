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

  def edit

  end
end
