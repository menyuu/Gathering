class EndUser::GroupMultiToggleController < ApplicationController
  before_action :authenticate_end_user!
  before_action :ensure_correct_user
  before_action :forbid_guestuser

  # グループ新規作成完了後にユーザーと同様にタグ付け可能
  def complete
    @group = Group.find(params[:group_id])
    @tag = Tag.new
    @tags = Tag.display_show_type("group")
    @tag_names = @group.tag_names
    @genre = Genre.new
    @genres = Genre.display_show_type("group")
    @genre_names = @group.genre_names
    @game = Game.new
    @games = Game.display_show_type("group")
    @game_names = @group.game_names
  end

  # グループタグ
  def tags
    @group = Group.find(params[:group_id])
    @tag = Tag.new
    @tags = Tag.display_show_type("group")
    @tag_names = @group.tag_names
  end

  def create_tags
    @group = Group.find(params[:group_id])
    @tag = Tag.new
    tags = params[:tag][:name].split(",")
    if tags.size <= 8 && tags.all? { |tag| tag.length <= 50 } && tags.all? { |tag| tag != "" }
      Tag.create_tag(tags, @group)
    else
      render "layouts/tag_error"
    end
    @tags = Tag.display_show_type(params[:tag][:model])
    @tag_names = @group.tag_names
  end

  def update_tags
    @group = Group.find(params[:group_id])
    @tag = Tag.new
    if @group.tags.size < 8
      Tag.update_tag(params[:name], @group)
      @tags = Tag.display_show_type(params[:model])
    else
      render "layouts/tag_error"
    end
    @tag_names = @group.tag_names
  end

  def destroy_tags
    @group = Group.find(params[:group_id])
    @tag = Tag.new
    Tag.destroy_tag(params[:name], @group)
    @tags = Tag.display_show_type(params[:model])
    @tag_names = @group.tag_names
  end

  # グループジャンル
  def genres
    @group = Group.find(params[:group_id])
    @genre = Genre.new
    @genres = Genre.display_show_type("group")
    @genre_names = @group.genre_names
  end

  def create_genres
    @group = Group.find(params[:group_id])
    @genre = Genre.new
    genres = params[:genre][:name].split(",")
    if genres.size <= 8 && genres.all? { |genre| genre.length <= 50 } && genres.all? { |genre| genre != "" }
      Genre.create_genre(genres, @group)
    else
      render "layouts/genre_error"
    end
    @genres = Genre.display_show_type(params[:genre][:model])
    @genre_names = @group.genre_names
  end

  def update_genres
    @group = Group.find(params[:group_id])
    @genre = Genre.new
    if @group.genres.size < 8
      Genre.update_genre(params[:name], @group)
    else
      render "layouts/genre_error"
    end
    @genres = Genre.display_show_type(params[:model])
    @genre_names = @group.genre_names
  end

  def destroy_genres
    @group = Group.find(params[:group_id])
    @genre = Genre.new
    Genre.destroy_genre(params[:name], @group)
    @genres = Genre.display_show_type(params[:model])
    @genre_names = @group.genre_names
  end

  # グループゲーム
  def games
    @group = Group.find(params[:group_id])
    @game = Game.new
    @games = Game.display_show_type("group")
    @game_names = @group.game_names
  end

  def create_games
    @group = Group.find(params[:group_id])
    @game = Game.new
    games = params[:game][:name].split(",")
    if games.size <= 8 && games.all? { |game| game.length <= 50 } && games.all? { |game| game != "" }
      Game.create_game(games, @group)
    else
      render "layouts/game_error"
    end
    @games = Game.display_show_type(params[:game][:model])
    @game_names = @group.game_names
  end

  def update_games
    @group = Group.find(params[:group_id])
    @game = Game.new
    if @group.games.size < 8
      Game.update_game(params[:name], @group)
    else
      render "layouts/game_error"
    end
    @games = Game.display_show_type(params[:model])
    @game_names = @group.game_names
  end

  def destroy_games
    @group = Group.find(params[:group_id])
    @game = Game.new
    Game.destroy_game(params[:name], @group)
    @games = Game.display_show_type(params[:model])
    @game_names = @group.game_names
  end

  private

  def ensure_correct_user
    group = Group.find(params[:group_id])
    unless current_end_user.id == group.owner_id
      redirect_to groups_path, alert: "オーナーではないため編集できません。"
    end
  end
end
