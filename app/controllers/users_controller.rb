class UsersController < ApplicationController
  def create
    @user = User.new(params[:user])
    if @user.save
      cookies[:auth_token] = @user.auth_token
      redirect_to posts_path, notice: "Successfully Sign up"
    else
      render :new
    end
  end

  def new
    @user = User.new
  end
end
