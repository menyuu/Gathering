class Admin::PostingTagsController < ApplicationController
  before_action :login_end_user
  before_action :authenticate_admin!
  
  def index
    @post_tags = PostingTag.all.sort{ |a,b| b.posts.size <=> a.posts.size}
  end

  def destroy
    @post_tag = PostingTag.find(params[:id])
    @post_tag.destroy
    @post_tags = PostingTag.all.sort{ |a,b| b.posts.size <=> a.posts.size}
  end

  def search
    @post_tags = PostingTag.all.sort{ |a,b| b.posts.size <=> a.posts.size}
    @search_result = PostingTag.find_by(name: params[:name])
    @search_name = params[:name]
    render :search_result
  end
end
