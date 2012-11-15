class PostsController < ApplicationController
  before_filter :authorize, only: [:vote, :new]
  
  def index
    
    if params[:tag]
      @posts = Post.tagged_with(params[:tag])
    elsif params[:latest] 
      @posts = Post.order(:created_at).reverse
    elsif params[:hot]
      @posts = Post.all.sort_by{ |post| post.comments.count}
    else params[:score]
      @posts = Post.all.sort_by{ |post| post.reputation_for(:votes).to_i}.reverse 
    end

    if params[:q]
      @search = Post.search(params[:q])
      @post = @search.result
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
