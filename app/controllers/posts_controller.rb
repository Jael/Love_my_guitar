class PostsController < ApplicationController
  before_filter :authorize, only: [:vote, :new]
  
  def index
    @search = Post.search(params[:q])
    if params[:tag]
      @posts = Post.tagged_with(params[:tag])
    elsif params[:q]
      @posts = @search.result
    elsif params[:latest] 
      @posts = Post.order(:created_at).reverse
    elsif params[:hot]
      @posts = Post.all.sort_by{ |post| post.comments.count}.reverse
    elsif params[:score]
      @posts = Post.all.sort_by{ |post| post.reputation_for(:votes).to_i}.reverse
    else
      @posts = Post.all
    end
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    if current_user
      @comment.user_id = current_user.id
    end
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

  def edit
    @post = Post.find(params[:id])
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to :back, notice: "Successfully destroy the post!"
  end

  def vote
    value = params[:type] == "up" ? 1 : -1
    @post = Post.find(params[:id])
    @post.add_or_update_evaluation(:votes, value, current_user)
    redirect_to :back, notice: "Thank you for voting!"
  end

  def user_post
    @search = Post.search(params[:q])
    @user = User.find(params[:user_id])
    @posts = Post.where("user_id = ?", params[:user_id])
    if params[:q]
      @posts = @search.result
    end
  end

end
