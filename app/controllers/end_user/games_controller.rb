class EndUser::GamesController < ApplicationController
  def index
    @games = Game.display_show_type("user")
    @game = Game.new
  end

  def create
    Game.create_game(params[:game][:name], current_end_user)
    @games = Game.display_show_type(params[:game][:model])
    @game = Game.new
  end

  def update
    Game.update_game(params[:name], current_end_user)
    @games = Game.display_show_type(params[:model])
    @game = Game.new
  end

  def destroy
    Game.destroy_game(params[:name], current_end_user)
    @games = Game.display_show_type(params[:model])
    @game = Game.new
  end
end
