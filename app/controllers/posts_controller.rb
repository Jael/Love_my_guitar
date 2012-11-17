class PostsController < ApplicationController
  before_filter :authorize, only: [:vote, :new]
  
  def index
    if params[:tag]
      @posts = Post.page(params[:page]).tagged_with(params[:tag])
    end
    
    if params[:latest] 
      @posts = Post.page(params[:page]).order(:created_at).reverse
    elsif params[:hot]
      @posts = Post.page(params[:page]).sort_by{ |post| post.comments.count}.reverse
    elsif params[:score]
      @posts = Post.page(params[:page]).sort_by{ |post| post.reputation_for(:votes).to_i}.reverse 
    else
      @posts = Post.page(params[:page])
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

  def vote
    value = params[:type] == "up" ? 1 : -1
    @post = Post.find(params[:id])
    @post.add_or_update_evaluation(:votes, value, current_user)
    redirect_to :back, notice: "Thank you for voting!"
  end

  def user_post
    @user = User.find(params[:user_id])
   # @posts = @user.posts.page(params{:page})
    @posts = Post.page(params[:page]).where("user_id = ?", params[:user_id])
  end

end
