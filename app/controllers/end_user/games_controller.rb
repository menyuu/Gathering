class EndUser::GamesController < ApplicationController
  before_action :authenticate_end_user!
  before_action :forbid_guestuser, only: [:create, :update, :destroy]
  
  def index
    @game = Game.new
    @games = Game.display_show_type("user")
    games = current_end_user.games
    @game_names = []
    if games.count > 0
      @game_names = games.pluck(:name).join(",") + ","
    else
      @game_names = games.pluck(:name).join(",")
    end
  end

  def create
    @game = Game.new
    games = params[:game][:name].split(",")
    if games.size < 9  && params[:game][:name].length < 51
      Game.create_game(games, current_end_user)
      @games = Game.display_show_type(params[:game][:model])
    else
      redirect_to request.referer, alert: "ゲームの追加に失敗しました。追加できるゲームは50文字以内、もしくは8個までです。"
    end
    games = current_end_user.games
    @game_names = []
    if games.count > 0
      @game_names = games.pluck(:name).join(",") + ","
    else
      @game_names = games.pluck(:name).join(",")
    end
  end

  def update
    @game = Game.new
    unless current_end_user.games.size == 8
      Game.update_game(params[:name], current_end_user)
      @games = Game.display_show_type(params[:model])
    else
      redirect_to request.referer, alert: "ゲームの追加に失敗しました。追加できるゲームは8個までです。"
    end
    games = current_end_user.games
    @game_names = []
    if games.count > 0
      @game_names = games.pluck(:name).join(",") + ","
    else
      @game_names = games.pluck(:name).join(",")
    end
  end

  def destroy
    @game = Game.new
    Game.destroy_game(params[:name], current_end_user)
    @games = Game.display_show_type(params[:model])
    games = current_end_user.games
    @game_names = []
    if games.count > 0
      @game_names = games.pluck(:name).join(",") + ","
    else
      @game_names = games.pluck(:name).join(",")
    end
  end
end
