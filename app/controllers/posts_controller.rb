class PostsController < ApplicationController
 before_filter :authorize, only: [:vote, :new]
  def index
    @posts = Post.order(:created_at).reverse
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(title: params[:title], url: params[:url])
    if @post.save
      redirect_to @post, notice: "Successfully create the post"
    else
      flash.now.alert = "error"
      render :new
    end
  end

  def vote
    value = params[:type] == "up" ? 1 : -1
    @post = Post.find(params[:id])
    @post.add_or_update_evaluation(:votes, value, current_user)
    redirect_to :back, notice: "Thank you for voting!"
  end

end
