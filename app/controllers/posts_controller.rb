class PostsController < ApplicationController
  before_action :set_post, only: %i[show update edit vote]
  before_action :require_login, except: %i[index show]

  def index
    @posts = Post.all
  end

  def show
    @comment = Comment.new
  end

  def new
    @post = Post.new
  end

  def edit; end

  def create
    @post = Post.new(post_params)
    @post.user = current_user

    if @post.save
      flash[:notice] = 'Your post was created'
      redirect_to posts_path
    else
      render 'new'
    end
  end

  def update
    if @post.update(post_params)
      flash[:notice] = 'Your post was updated'
      redirect_to post_path(@post)
    else
      render 'edit'
    end
  end

  def vote
    post_vote = Vote.create voteable: @post, user: current_user, vote: params.permit(:vote)[:vote]

    if post_vote.valid?
      flash.now[:notice] = 'Your vote was counted.'
    else
      flash.now[:error] = "You've already voted for this comment"
    end

    respond_to do |format|
      format.js
    end
  end

  private

  def post_params
    params.require(:post).permit!
  end

  def set_post
    @post = Post.find params[:id]
  end
end
