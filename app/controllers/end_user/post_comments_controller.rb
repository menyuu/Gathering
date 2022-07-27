class EndUser::PostCommentsController < ApplicationController
  def create
    post = Post.find(params[:post_id])
    post_comment = current_end_user.post_comments.new(comment_params)
    post_comment.post_id = post.id
    post_comment.save
    redirect_to post_path(post)
  end

  def destroy
    PostComment.find(params[:id]).destroy
    redirect_to post_path(params[:post_id])
  end

  private

  def comment_params
    params.require(:post_comment).permit(:text)
  end

end