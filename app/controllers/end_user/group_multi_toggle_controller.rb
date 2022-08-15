class EndUser::GroupMultiToggleController < ApplicationController
  before_action :authenticate_end_user!
  before_action :ensure_correct_user
  before_action :forbid_guestuser
  def tags
    @group = Group.find(params[:group_id])
    @tags = Tag.display_show_type("group")
    @tag = Tag.new
  end

  def create_tags
    @group = Group.find(params[:group_id])
    Tag.create_tag(params[:tag][:name], @group)
    @tags = Tag.display_show_type(params[:tag][:model])
    @tag = Tag.new
  end

  def update_tags
    @group = Group.find(params[:group_id])
    Tag.update_tag(params[:name], @group)
    @tags = Tag.display_show_type(params[:model])
    @tag = Tag.new
  end

  def destroy_tags
    @group = Group.find(params[:group_id])
    Tag.destroy_tag(params[:name], @group)
    @tags = Tag.display_show_type(params[:model])
    @tag = Tag.new
  end

  def genres
    @group = Group.find(params[:group_id])
    @genres = Genre.display_show_type("group")
    @genre = Genre.new
  end

  def create_genres
    @group = Group.find(params[:group_id])
    Genre.create_genre(params[:genre][:name], @group)
    @genres = Genre.display_show_type(params[:genre][:model])
    @genre = Genre.new
  end

  def update_genres
    @group = Group.find(params[:group_id])
    Genre.update_genre(params[:name], @group)
    @genres = Genre.display_show_type(params[:model])
    @genre = Genre.new
  end

  def destroy_genres
    @group = Group.find(params[:group_id])
    Genre.destroy_genre(params[:name], @group)
    @genres = Genre.display_show_type(params[:model])
    @genre = Genre.new
  end

  def games
    @group = Group.find(params[:group_id])
    @games = Game.display_show_type("group")
    @game = Game.new
  end

  def create_games
    @group = Group.find(params[:group_id])
    Game.create_game(params[:game][:name], @group)
    @games = Game.display_show_type(params[:game][:model])
    @game = Game.new
  end

  def update_games
    @group = Group.find(params[:group_id])
    Game.update_game(params[:name], @group)
    @games = Game.display_show_type(params[:model])
    @game = Game.new
  end

  def destroy_games
    @group = Group.find(params[:group_id])
    Game.destroy_game(params[:name], @group)
    @games = Game.display_show_type(params[:model])
    @game = Game.new
  end

  private

  def ensure_correct_user
    group = Group.find(params[:group_id])
    unless current_end_user.id == group.owner_id
      redirect_to groups_path, alert: "オーナーではないため編集できません。"
    end
  end
end
