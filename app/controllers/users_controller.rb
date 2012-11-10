class UsersController < ApplicationController
  def create
    @user = User.create(params[:user])
    session[:user_id] = @user
    redirect_to posts_path, notice: "Successfully Sign up"
  end

  def new
    @user = User.new
  end
end
