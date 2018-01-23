class CommentsController < ApplicationController
  before_action :require_login

  def create
    @post = Post.find params[:post_id]
    @comment = @post.comments.new(params.require(:comment).permit(:body))
    @comment.user = current_user

    if @comment.save
      flash[:notice] = "You've successfully added the comment."
      redirect_to post_path(@post)
    else
      render 'posts/show'
    end
  end

  def vote
    @comment = Comment.find params[:id]
    comment_vote = Vote.create voteable: @comment, user: current_user, vote: params.permit(:vote)[:vote]

    if comment_vote.valid?
      flash.now[:notice] = 'Your vote was counted.'
    else
      flash.now[:error] = "You've already voted for this comment"
    end

    respond_to do |format|
      format.js
    end
  end
end
