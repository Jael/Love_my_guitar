class CommentsController < ApplicationController
  before_filter :authorize
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(params[:comment])
    if @comment.save
      redirect_to @post, notice: "Successfuly created the comment"
    end
  end
end
