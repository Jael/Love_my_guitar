class CommentsController < ApplicationController
  before_filter :authorize
  
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(params[:comment])
    redirect_to @post, notice: "Successfuly created the comment" if @comment.save
  end

end
