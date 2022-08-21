class EndUser::GenresController < ApplicationController
  before_action :authenticate_end_user!
  before_action :forbid_guestuser, only: [:create, :update, :destroy]

  def index
    @genre = Genre.new
    @genres = Genre.display_show_type("user")
    @genre_names = current_end_user.genre_names
  end

  def create
    @genre = Genre.new
    genres = params[:genre][:name].split(",")
    if genres.size <= 8 && genres.all? { |genre| genre.length <= 50 }
      Genre.create_genre(genres, current_end_user)
    else
      render "layouts/error"
    end
    @genres = Genre.display_show_type(params[:genre][:model])
    @genre_names = current_end_user.genre_names
  end

  def update
    @genre = Genre.new
    unless current_end_user.genres.size == 8
      Genre.update_genre(params[:name], current_end_user)
      @genres = Genre.display_show_type(params[:model])
    else
      redirect_to request.referer, alert: "ジャンルの追加に失敗しました。追加できるジャンルは8個までです。"
    end
    genres = current_end_user.genres
    @genre_names = []
    if genres.count > 0
      @genre_names = genres.pluck(:name).join(",") + ","
    else
      @genre_names = genres.pluck(:name).join(",")
    end
  end

  def destroy
    @genre = Genre.new
    Genre.destroy_genre(params[:name], current_end_user)
    @genres = Genre.display_show_type(params[:model])
    genres = current_end_user.genres.all
    @genre_names = []
    if genres.count > 0
      @genre_names = genres.pluck(:name).join(",") + ","
    else
      @genre_names = genres.pluck(:name).join(",")
    end
  end
end
