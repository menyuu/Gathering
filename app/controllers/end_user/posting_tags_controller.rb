class EndUser::PostingTagsController < ApplicationController
  def create
    post = Post.find(params[:post_id])
    tags = params[:posting_tag][:name].split(",")
    tags.each do |tag|
      tag = PostingTag.find_or_create_by(name: tag)
      post.tags.delete(tag)
      post.tags << tag
    end
    redirect_to request.referer
  end

  def update
    post = Post.find(params[:post_id])
    tag = PostingTag.find_by(name: params[:name])
    post.tags.delete(tag)
    post.tags << tag
    redirect_to request.referer
  end

  def destroy
    post = Post.find(params[:post_id])
    tag = PostingTag.find_by(name: params[:name])
    if post.tags.size > 1
      post.tags.delete(tag)
      redirect_to request.referer
    else
      redirect_to request.referer
    end
  end
end
