class EndUser::TagsController < ApplicationController
  def index
    @tags = Tag.display_show_type("user")
    @tag = Tag.new
  end

  def create
    @tag = Tag.new
    @tags = Tag.display_show_type(params[:tag][:model])
    unless current_end_user.tags.size == 10 || params[:tag][:name].length >= 50
      Tag.create_tag(params[:tag][:name], current_end_user)
    else
      render :errors
      flash[:notice] = "タグの追加に失敗しました。追加できるタグは50文字以内、もしくは10個までです。"
    end
  end

  def update
    @tag = Tag.new
    @tags = Tag.display_show_type(params[:model])
    unless current_end_user.tags.size == 10
      Tag.update_tag(params[:name], current_end_user)
    else
      render :errors
      flash[:notice] = "タグの追加に失敗しました。追加できるタグは10個までです。"
    end
  end

  def destroy
    Tag.destroy_tag(params[:name], current_end_user)
    @tags = Tag.display_show_type(params[:model])
    @tag = Tag.new
  end
end
