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
end
