class EndUser::GenresController < ApplicationController
  before_action :authenticate_end_user!
  before_action :notification_index, only: [:index]

  def index
    @genre = Genre.new
    @genres = Genre.display_show_type("user")
    @genre_names = current_end_user.genre_names
  end

  def create
    @genre = Genre.new
    genres = params[:genre][:name].split(",")
    if genres.size <= 8 && genres.all? { |genre| genre.length <= 50 } && genres.all? { |genre| genre != "" }
      Genre.create_genre(genres, current_end_user)
    else
      render "layouts/genre_error"
    end
    @genres = Genre.display_show_type(params[:genre][:model])
    @genre_names = current_end_user.genre_names
  end

  def update
    @genre = Genre.new
    if current_end_user.genres.size < 8
      Genre.update_genre(params[:name], current_end_user)
    else
      render "layouts/genre_error"
    end
    @genres = Genre.display_show_type(params[:model])
    @genre_names = current_end_user.genre_names
  end

  def destroy
    @genre = Genre.new
    Genre.destroy_genre(params[:name], current_end_user)
    @genres = Genre.display_show_type(params[:model])
    @genre_names = current_end_user.genre_names
  end
end
