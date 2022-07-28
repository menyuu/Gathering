class EndUser::GamesController < ApplicationController
  def index
    @games = Game.all
    @game = Game.new
  end

  def create
    get_value = current_end_user
    games = params[:game][:name].split(",")
    games.each do |game|
      game = Game.find_or_create_by(name: game)
      get_value.games.delete(game)
      get_value.games << game
    end
    redirect_to request.referer
  end

  def update
    game = Game.find_by(name: params[:name])
    current_end_user.games.delete(game)
    current_end_user.games << game
    redirect_to request.referer
  end

  def destroy
    game = Game.find_by(name: params[:name])
    if current_end_user.games.size > 1
      current_end_user.games.delete(game)
      redirect_to request.referer
    else
      redirect_to request.referer
    end
  end
end
