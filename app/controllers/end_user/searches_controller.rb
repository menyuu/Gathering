class EndUser::SearchesController < ApplicationController
  before_action :authenticate_end_user!

  def search
    @object = params[:object]
    @word = params[:word]
    @user_id = params[:user_id].to_i
    @group_id = params[:group_id].to_i
    case @object
    # ユーザー検索
    when "id"
      search_result = EndUser.search_for(@object, @word, @user_id)
      if search_result.present?
        @search_result = Kaminari.paginate_array(search_result).page(params[:page]).per(1)
      end
    when "user"
      @search_result = Kaminari.paginate_array(EndUser.search_for(@object, @word, nil)).page(params[:page]).per(1)
    when "user_keyword"
      @search_result = Kaminari.paginate_array(EndUser.search_for(@object, @word, nil)).page(params[:page]).per(1)

    # グループ検索
    when "group_id"
      search_result = Group.search_for(@object, @word, @group_id)
      if search_result.present?
        @search_result = Kaminari.paginate_array(search_result).page(params[:page]).per(1)
      end
    when "group"
      @search_result = Kaminari.paginate_array(Group.search_for(@object, @word, nil)).page(params[:page]).per(1)
    when "group_keyword"
      @search_result = Kaminari.paginate_array(Group.search_for(@object, @word, nil)).page(params[:page]).per(1)

    #　投稿検索
    when "post"
      @search_result = Kaminari.paginate_array(Post.search_for(@word)).page(params[:page]).per(1)
      @post_comment = PostComment.new
    when "post_tag"
      search_result = PostingTag.search_for(@word)
      if search_result.present?
        @search_result = Kaminari.paginate_array(search_result.posts.with_attached_images.includes(:user, :tags, :post_tags)).page(params[:page]).per(1)
      end
      @post_comment = PostComment.new

    # ユーザータグ検索用
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

    # グループタグ検索用
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
