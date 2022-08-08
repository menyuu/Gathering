class EndUser::GenresController < ApplicationController
  def index
    @genres = Genre.display_show_type("user")
    @genre = Genre.new
  end

  def create
    Genre.create_genre(params[:genre][:name], current_end_user)
    @genres = Genre.display_show_type(params[:genre][:model])
    @genre = Genre.new
  end

  def update
    Genre.update_genre(params[:name], current_end_user)
    @genres = Genre.display_show_type(params[:model])
    @genre = Genre.new
  end

  def destroy
    Genre.destroy_genre(params[:name], current_end_user)
    @genres = Genre.display_show_type(params[:model])
    @genre = Genre.new
  end
end
