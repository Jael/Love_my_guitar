class PostsController < ApplicationController
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
    @post = Post.new(params[:post])
    if @post.save
      redirect_to @post, notice: "Successfully create the post"
    else
      flash.now.alert = "error"
      render :new
    end
  end

end
