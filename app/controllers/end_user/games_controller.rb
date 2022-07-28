class EndUser::GamesController < ApplicationController
  def index
    @games = Game.all
    @game = Game.new
  end

  def create
    if params[:game][:model] == "user"
      create_game_model = current_end_user
    elsif params[:game][:model] == "group"
      create_game_model = Group.find(params[:game][:id])
    end
    games = params[:game][:name].split(",")
    games.each do |game|
      game = Game.find_or_create_by(name: game)
      create_game_model.games.delete(game)
      create_game_model.games << game
    end
    redirect_to request.referer
  end

  def update
    if params[:model] == "user"
      add_game_model = current_end_user
    elsif params[:model] == "group"
      add_game_model = Group.find(params[:id])
    end
    game = Game.find_by(name: params[:name])
    add_game_model.games.delete(game)
    add_game_model.games << game
    redirect_to request.referer
  end

  def destroy
    if params[:model] == "user"
      remove_game_model = current_end_user
    elsif params[:model] == "group"
      remove_game_model = Group.find(params[:id])
    end
    game = Game.find_by(name: params[:name])
    if remove_game_model.games.size > 1
      remove_game_model.games.delete(game)
      redirect_to request.referer
    else
      redirect_to request.referer
    end
  end
end
