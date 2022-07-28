class EndUser::GenresController < ApplicationController
  def index
    @genres = Genre.all
    @genre = Genre.new
  end

  def create
    get_value = current_end_user
    genres = params[:genre][:name].split(",")
    genres.each do |genre|
      genre = Genre.find_or_create_by(name: genre)
      get_value.genres.delete(genre)
      get_value.genres << genre
    end
    redirect_to request.referer
  end

  def update
    genre = Genre.find_by(name: params[:name])
    current_end_user.genres.delete(genre)
    current_end_user.genres << genre
    redirect_to request.referer
  end

  def destroy
    genre = Genre.find_by(name: params[:name])
    if current_end_user.genres.size > 1
      current_end_user.genres.delete(genre)
      redirect_to request.referer
    else
      redirect_to request.referer
    end
  end
end
