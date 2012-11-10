class UsersController < ApplicationController
  def create
    @user = User.new(params[:user])
    if @user.save
      session[:user_id] = @user
      redirect_to posts_path, notice: "Successfully Sign up"
    else
      render :new
    end
  end

  def new
    @user = User.new
  end
end
