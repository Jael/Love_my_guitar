class PostsController < ApplicationController
  before_filter :authorize, only: [:vote, :new]
  
  def index
    if params[:tag]
      @posts = Post.tagged_with(params[:tag])
    else 
      @posts = Post.order(:created_at).reverse
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(params[:post])
    if @post.save
      redirect_to @post, notice: "Successfully create the post"
    else
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
    @user = User.find(params[:user_id])
    @posts = @user.posts.all
  end

end
