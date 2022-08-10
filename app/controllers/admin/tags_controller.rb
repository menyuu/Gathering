class Admin::TagsController < ApplicationController
  def index
    @prepared_tags = Tag.where(status: "prepared").order(created_at: :DESC)
    @self_made_tags = Tag.where(status: "self_made").order(created_at: :DESC)
    @hide_tags =Tag.where(status: "hide").order(updated_at: :DESC)
    @tag = Tag.new
  end

  def create
    @tag = Tag.find_or_create_by(tag_params)
    @prepared_tags = Tag.where(status: "prepared").order(created_at: :DESC)
    @self_made_tags = Tag.where(status: "self_made").order(created_at: :DESC)
    @hide_tags =Tag.where(status: "hide").order(updated_at: :DESC)
  end

  def update
    @tag = Tag.find(params[:id])
    @tag.update(status: params[:status])
    @prepared_tags = Tag.where(status: "prepared").order(created_at: :DESC)
    @self_made_tags = Tag.where(status: "self_made").order(created_at: :DESC)
    @hide_tags =Tag.where(status: "hide").order(updated_at: :DESC)
  end

  def destroy
    @tag = Tag.find(params[:id])
    @tag.destroy
    @prepared_tags = Tag.where(status: "prepared").order(created_at: :DESC)
    @self_made_tags = Tag.where(status: "self_made").order(created_at: :DESC)
    @hide_tags =Tag.where(status: "hide").order(updated_at: :DESC)
  end

  private

  def tag_params
    params.require(:tag).permit(:name, :status)
  end
end
