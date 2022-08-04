class EndUser::PostingTagsController < ApplicationController
  def show
    @post = Post.find(params[:post_id])
    @post_tags = PostingTag.all.sort {|a,b| b.posts.size <=> a.posts.size}.first(30)
    @post_tag = PostingTag.new
  end

  def create
    @post = Post.find(params[:post_id])
    tags = params[:posting_tag][:name].split(",")
    tags.each do |tag|
      tag = PostingTag.find_or_create_by(name: tag)
      @post.tags.delete(tag)
      @post.tags << tag
    end
    @post_tags = PostingTag.all.sort {|a,b| b.posts.size <=> a.posts.size}.first(30)
    @post_tag = PostingTag.new
  end

  def update
    @post = Post.find(params[:post_id])
    tag = PostingTag.find_by(name: params[:name])
    @post.tags.delete(tag)
    @post.tags << tag
    @post_tags = PostingTag.all.sort {|a,b| b.posts.size <=> a.posts.size}.first(30)
    @post_tag = PostingTag.new
  end

  def destroy
    @post = Post.find(params[:post_id])
    tag = PostingTag.find_by(name: params[:name])
    @post.tags.delete(tag)
    @post_tags = PostingTag.all.sort {|a,b| b.posts.size <=> a.posts.size}.first(30)
    @post_tag = PostingTag.new
  end
end
