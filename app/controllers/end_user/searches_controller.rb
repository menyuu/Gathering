class EndUser::SearchesController < ApplicationController
  def search
    @object = params[:object]
    @word = params[:word]
    @user_id = params[:user_id].to_i
    case @object
    when "id"
      @search_result = EndUser.search_for(@object, @word, @user_id)
    when "user"
      @search_result = EndUser.search_for(@object, @word, nil)
    when "post"
      @search_result = Post.search_for(@word)
    when "post_tag"
      @search_result = PostingTag.search_for(@word)
    when "group"
      @search_result = Group.search_for(@word)
    when "tag"
      @search_result = Tag.search_for(@word)
    when "genre"
      @search_result = Genre.search_for(@word)
    when "game"
      @search_result = Game.search_for(@word)
    end
  end
end
