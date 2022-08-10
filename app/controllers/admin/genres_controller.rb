class Admin::GenresController < ApplicationController
  before_action :authenticate_admin!
  before_action :admin_display_show_genres

  def index
    @tag = Tag.new
  end

  def create
    @tag = Tag.find_or_initialize_by(tag_params)
    @tag.save
    @tag.update(status: "hide")
  end

  def update
    @tag = Tag.find(params[:id])
    @tag.update(status: params[:status])
  end

  def destroy
    @tag = Tag.find(params[:id])
    @tag.destroy
  end

  private

  def tag_params
    params.require(:tag).permit(:name)
  end

  def admin_display_show_tags
    @prepared_tags = Tag.where(status: "prepared").order(updated_at: :DESC)
    @self_made_tags = Tag.where(status: "self_made").order(updated_at: :DESC)
    @hide_tags = Tag.where(status: "hide").order(updated_at: :DESC)
  end
end
