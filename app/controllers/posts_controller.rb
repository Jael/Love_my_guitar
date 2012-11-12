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
    @post = current_user.posts.new(title: params[:title], url: params[:url])
    if @post.save
      redirect_to @post, notice: "Successfully create the post"
    else
      flash.now.alert = "Please input the title"
      render :new
    end
  end

  def vote
    value = params[:type] == "up" ? 1 : -1
    @post = Post.find(params[:id])
    @post.add_or_update_evaluation(:votes, value, current_user)
    redirect_to :back, notice: "Thank you for voting!"
  end

  def user_post
    current_user = User.find(params[:user_id])
    @posts = current_user.posts.all
  end

end
