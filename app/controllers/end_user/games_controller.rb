class EndUser::GamesController < ApplicationController
  before_action :login_admin
  before_action :authenticate_end_user!
  before_action :notification_index, only: [:index]

  def index
    @game = Game.new
    @games = Game.display_show_type("user")
    @game_names = current_end_user.game_names
  end

  def create
    @game = Game.new
    games = params[:game][:name].split(",")
    if games.size <= 8 && games.all? { |game| game.length <= 50 } && games.all? { |game| game != "" }
      Game.create_game(games, current_end_user)
    else
      render "layouts/game_error"
    end
    @games = Game.display_show_type(params[:game][:model])
    @game_names = current_end_user.game_names
  end

  def update
    @game = Game.new
    if current_end_user.games.size < 8
      Game.update_game(params[:name], current_end_user)
    else
      render "layouts/game_error"
    end
    @games = Game.display_show_type(params[:model])
    @game_names = current_end_user.game_names
  end

  def destroy
    @game = Game.new
    Game.destroy_game(params[:name], current_end_user)
    @games = Game.display_show_type(params[:model])
    @game_names = current_end_user.game_names
  end
end
