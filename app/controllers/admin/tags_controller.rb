class Admin::TagsController < ApplicationController
  before_action :login_end_user
  before_action :authenticate_admin!
  before_action :admin_display_show_tags

  def index
    @tag = Tag.new
  end

  def create
    @tag = Tag.find_or_initialize_by(tag_params)
    if @tag.save
      @tag.update(status: "hide")
    else
      render "layouts/error"
    end
  end

  def update
    @tag = Tag.find(params[:id])
    @tag.update(status: params[:status])
  end

  def destroy
    @tag = Tag.find(params[:id])
    @tag.destroy
  end

  def search
    @search_result = Tag.find_by(name: params[:name])
    @search_name = params[:name]
    render :search_result
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
