class EndUser::GenresController < ApplicationController
  def index
    @genres = Genre.all
    @genre = Genre.new
  end

  def create
    if params[:genre][:model] == "user"
      create_genre_model = current_end_user
    elsif params[:genre][:model] == "group"
      create_genre_model = Group.find(params[:genre][:id])
    end
    genres = params[:genre][:name].split(",")
    genres.each do |genre|
      genre = Genre.find_or_create_by(name: genre)
      create_genre_model.genres.delete(genre)
      create_genre_model.genres << genre
    end
    redirect_to request.referer
  end

  def update
    if params[:model] == "user"
      add_genre_model = current_end_user
    elsif params[:model] == "group"
      add_genre_model = Group.find(params[:id])
    end
    genre = Genre.find_by(name: params[:name])
    add_genre_model.genres.delete(genre)
    add_genre_model.genres << genre
    redirect_to request.referer
  end

  def destroy
    if params[:model] == "user"
      remove_genre_model = current_end_user
    elsif
      remove_genre_model = Group.find(params[:id])
    end
    genre = Genre.find_by(name: params[:name])
    if remove_genre_model.genres.size > 1
      remove_genre_model.genres.delete(genre)
      redirect_to request.referer
    else
      redirect_to request.referer
    end
  end
end
