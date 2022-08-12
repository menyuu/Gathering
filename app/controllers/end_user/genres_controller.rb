class EndUser::GenresController < ApplicationController
  def index
    @genre = Genre.new
    @genres = Genre.display_show_type("user")
  end

  def create
    @genre = Genre.new
    @genres = Genre.display_show_type(params[:genre][:model])
    unless current_end_user.genres.size == 10 || params[:genre][:name].length >= 50
      Genre.create_genre(params[:genre][:name], current_end_user)
    else
      redirect_to request.referer, notice: "ジャンルの追加に失敗しました。追加できるジャンルは50文字以内、もしくは10個までです。"
    end
  end

  def update
    @genre = Genre.new
    @genres = Genre.display_show_type(params[:model])
    unless current_end_user.genres.size == 10
      Genre.update_genre(params[:name], current_end_user)
    else
      redirect_to request.referer, notice: "ジャンルの追加に失敗しました。追加できるジャンルは10個までです。"
    end
  end

  def destroy
    @genre = Genre.new
    @genres = Genre.display_show_type(params[:model])
    Genre.destroy_genre(params[:name], current_end_user)
  end
end
