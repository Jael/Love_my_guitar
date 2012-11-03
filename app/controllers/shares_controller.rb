class SharesController < ApplicationController
  def create
    post = Post.find(params[:post_id])
    ShareMailer.share_email(post, params[:email], params[:name], params[:message]).deliver
    redirect_to posts_path, notice: "Email has been send!"
  end
end
