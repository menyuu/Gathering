class EndUser::GamesController < ApplicationController
  before_action :authenticate_end_user!
  before_action :forbid_guestuser, only: [:create, :update, :destroy]
  
  def index
    @game = Game.new
    @games = Game.display_show_type("user")
  end

  def create
    @game = Game.new
    unless current_end_user.games.size == 8 || params[:game][:name].length >= 50
      Game.create_game(params[:game][:name], current_end_user)
      @games = Game.display_show_type(params[:game][:model])
    else
      redirect_to request.referer, notice: "ゲームの追加に失敗しました。追加できるゲームは50文字以内、もしくは8個までです。"
    end
  end

  def update
    @game = Game.new
    unless current_end_user.games.size == 8
      Game.update_game(params[:name], current_end_user)
      @games = Game.display_show_type(params[:model])
    else
      redirect_to request.referer, notice: "ゲームの追加に失敗しました。追加できるゲームは8個までです。"
    end
  end

  def destroy
    @game = Game.new
    @games = Game.display_show_type(params[:model])
    Game.destroy_game(params[:name], current_end_user)
  end
end
