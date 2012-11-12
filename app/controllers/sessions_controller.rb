class SessionsController < ApplicationController
  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      if params[:remember_me]
        cookies.permanent[:auth_token] = user.auth_token
      else
        cookies[:auth_token] = user.auth_token
      end
      redirect_to posts_path, notice: "Successfully sign in"
    else
      flash.now.alert = "Invalid email or password!"
      render "new"
    end
  end

  def destroy
    cookies.delete(:auth_token)
    redirect_to root_path, notice: "Successfully log out." 
  end
end
