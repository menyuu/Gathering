class EndUser::SearchesController < ApplicationController
  def search
    @object = params[:object]
    @word = params[:word]
    @id = params[:user_id].to_i
    @id = params[:group_id].to_i
    case @object
    when "id"
      search_result = EndUser.search_for(@object, @word, @id)
      @search_result = Kaminari.paginate_array(search_result).page(params[:page]).per(1)
    when "user"
      search_result = EndUser.search_for(@object, @word, nil)
      @search_result = Kaminari.paginate_array(search_result).page(params[:page]).per(1)
    when "user_keyword"
      search_result = EndUser.search_for(@object, @word, nil)
      @search_result = Kaminari.paginate_array(search_result).page(params[:page]).per(1)
    when "group_id"
      search_result = Group.search_for(@object, @word, @id)
      @search_result = Kaminari.paginate_array(search_result).page(params[:page]).per(1)
    when "group"
      search_result = Group.search_for(@object, @word, nil)
      @search_result = Kaminari.paginate_array(search_result).page(params[:page]).per(1)
    when "group_keyword"
      search_result = Group.search_for(@object, @word, nil)
      @search_result = Kaminari.paginate_array(search_result).page(params[:page]).per(1)
    when "post"
      search_result = Post.where(status: "published")
      search_result = search_result.search_for(@word)
      @search_result = Kaminari.paginate_array(search_result).page(params[:page]).per(1)
      @post_comment = PostComment.new
    when "post_tag"
      search_result = PostingTag.search_for(@word)
      if search_result.present?
        @search_result = Kaminari.paginate_array(search_result.posts).page(params[:page]).per(1)
      end
      @post_comment = PostComment.new
    when "tag"
      search_result = Tag.search_for(@word)
      @tags = Tag.display_show_type("user", 10)
      @user_search_tags = Tag.display_show_type("user")
      if search_result.present?
        @search_result = Kaminari.paginate_array(search_result.users).page(params[:page]).per(1)
      end
    when "genre"
      search_result = Genre.search_for(@word)
      @genres = Genre.display_show_type("user", 10)
      @user_search_genres = Genre.display_show_type("user")
      if search_result.present?
        @search_result = Kaminari.paginate_array(search_result.users).page(params[:page]).per(1)
      end
    when "game"
      search_result = Game.search_for(@word)
      @games = Game.display_show_type("user", 10)
      @user_search_games = Game.display_show_type("user")
      if search_result.present?
        @search_result = Kaminari.paginate_array(search_result.users).page(params[:page]).per(1)
      end
    when "group_tag"
      search_result = Tag.search_for(@word)
      @tags = Tag.display_show_type("group", 10)
      @user_search_tags = Tag.display_show_type("group")
      if search_result.present?
        @search_result = Kaminari.paginate_array(search_result.groups).page(params[:page]).per(1)
      end
    when "group_genre"
      search_result = Genre.search_for(@word)
      @genres = Genre.display_show_type("group", 10)
      @user_search_genres = Genre.display_show_type("group")
      if search_result.present?
        @search_result = Kaminari.paginate_array(search_result.groups).page(params[:page]).per(1)
      end
    when "group_game"
      search_result = Game.search_for(@word)
      @games = Game.display_show_type("group", 10)
      @user_search_games = Game.display_show_type("group")
      if search_result.present?
        @search_result = Kaminari.paginate_array(search_result.groups).page(params[:page]).per(1)
      end
    end
  end
end
