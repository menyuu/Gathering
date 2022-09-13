class EndUser::SearchesController < ApplicationController
  before_action :authenticate_end_user!
  before_action :common_search
  before_action :notification_index

  def search
    @object = params[:object]
    @word = params[:word]
    @user_id = params[:word].to_i
    @group_id = params[:word].to_i
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
      search_result = PostingTag.find_by(name: @word)
      if search_result.present?
        users = EndUser.where(status: "published")
        @search_result = Kaminari.paginate_array(search_result.posts.where(status: "published", end_user_id: users).with_attached_images.includes(:user, :tags, :post_tags).order(created_at: :DESC)).page(params[:page]).per(1)
      end
      @post_comment = PostComment.new

    # ユーザータグ検索用
    when "tag"
      search_result = Tag.find_by(name: @word)
      if search_result.present?
        @search_result = Kaminari.paginate_array(search_result.users.where(status: "published").order(created_at: :DESC)).page(params[:page]).per(1)
      end
    when "genre"
      search_result = Genre.find_by(name: @word)
      if search_result.present?
        @search_result = Kaminari.paginate_array(search_result.users.where(status: "published").order(created_at: :DESC)).page(params[:page]).per(1)
      end
    when "game"
      search_result = Game.find_by(name: @word)
      if search_result.present?
        @search_result = Kaminari.paginate_array(search_result.users.where(status: "published").order(created_at: :DESC)).page(params[:page]).per(1)
      end

    # グループタグ検索用
    when "group_tag"
      search_result = Tag.find_by(name: @word)
      if search_result.present?
        @search_result = Kaminari.paginate_array(search_result.groups.order(created_at: :DESC)).page(params[:page]).per(1)
      end
    when "group_genre"
      search_result = Genre.find_by(name: @word)
      if search_result.present?
        @search_result = Kaminari.paginate_array(search_result.groups.order(created_at: :DESC)).page(params[:page]).per(1)
      end
    when "group_game"
      search_result = Game.find_by(name: @word)
      if search_result.present?
        @search_result = Kaminari.paginate_array(search_result.groups.order(created_at: :DESC)).page(params[:page]).per(1)
      end
    end
  end

  def common_search
    @post_tags = PostingTag.display_show_type("post", 15)
    @tags = Tag.display_show_type("user", 15)
    @genres = Genre.display_show_type("user", 15)
    @games = Game.display_show_type("user", 15)
    @group_tags = Tag.display_show_type("group", 15)
    @group_genres = Genre.display_show_type("group", 15)
    @group_games = Game.display_show_type("group", 15)
  end
end
