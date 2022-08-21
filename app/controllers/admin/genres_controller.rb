class Admin::GenresController < ApplicationController
  before_action :authenticate_admin!
  before_action :admin_display_show_genres

  def index
    @genre = Genre.new
  end

  def create
    @genre = Genre.find_or_initialize_by(genre_params)
    if @genre.save
      @genre.update(status: "hide")
    else
      render "layouts/error"
    end
  end

  def update
    @genre = Genre.find(params[:id])
    @genre.update(status: params[:status])
  end

  def destroy
    @genre = Genre.find(params[:id])
    @genre.destroy
  end

  def search
    @search_result = Genre.find_by(name: params[:name])
    @search_name = params[:name]
    render :search_result
  end

  private

  def genre_params
    params.require(:genre).permit(:name)
  end

  def admin_display_show_genres
    @prepared_genres = Genre.where(status: "prepared").order(updated_at: :DESC)
    @self_made_genres = Genre.where(status: "self_made").order(updated_at: :DESC)
    @hide_genres = Genre.where(status: "hide").order(updated_at: :DESC)
  end
end
