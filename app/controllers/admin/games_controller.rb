class Admin::GamesController < ApplicationController
  before_action :authenticate_admin!
  before_action :admin_display_show_games

  def index
    @game = Game.new
  end

  def create
    @game = Game.find_or_initialize_by(game_params)
    @game.save
    @game.update(status: "hide")
    flash[:notice] =  "ゲームを作成しました。"
  end

  def update
    @game = Game.find(params[:id])
    @game.update(status: params[:status])
    flash[:notice] = "ゲームの情報を更新しました。"
  end

  def destroy
    @game = Game.find(params[:id])
    @game.destroy
    flash[:notice] = "ゲームを削除しました。"
  end

  private

  def game_params
    params.require(:game).permit(:name)
  end

  def admin_display_show_games
    @prepared_games = Game.where(status: "prepared").order(updated_at: :DESC)
    @self_made_games = Game.where(status: "self_made").order(updated_at: :DESC)
    @hide_games = Game.where(status: "hide").order(updated_at: :DESC)
  end
end
