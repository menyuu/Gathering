class Admin::PostingTagsController < ApplicationController
  def index
    @post_tags = PostingTag.all.sort{ |a,b| b.posts.size <=> a.posts.size}
  end

  def search
    @post_tags = PostingTag.all.sort{ |a,b| b.posts.size <=> a.posts.size}
    @search_result = PostingTag.find_by(name: params[:name])
    @search_name = params[:name]
    render :search_result
  end
end
