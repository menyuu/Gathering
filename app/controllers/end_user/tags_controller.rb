class EndUser::TagsController < ApplicationController
  before_action :authenticate_end_user!
  before_action :forbid_guestuser, only: [:create, :destroy]
  
  def index
    @tag = Tag.new
    @tags = Tag.display_show_type("user")
  end

  def create
    @tag = Tag.new
    unless current_end_user.tags.size == 8 || params[:tag][:name].length >= 50
      Tag.create_tag(params[:tag][:name], current_end_user)
      @tags = Tag.display_show_type(params[:tag][:model])
    else
      redirect_to request.referer, notice: "タグの追加に失敗しました。追加できるタグは50文字以内、もしくは8個までです。"
    end
  end

  def update
    @tag = Tag.new
    unless current_end_user.tags.size == 8
      Tag.update_tag(params[:name], current_end_user)
      @tags = Tag.display_show_type(params[:model])
    else
      redirect_to request.referer, notice: "タグの追加に失敗しました。追加できるタグは8個までです。"
    end
  end

  def destroy
    @tag = Tag.new
    Tag.destroy_tag(params[:name], current_end_user)
    @tags = Tag.display_show_type(params[:model])
  end
end
