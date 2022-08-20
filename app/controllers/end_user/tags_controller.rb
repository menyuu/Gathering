class EndUser::TagsController < ApplicationController
  before_action :authenticate_end_user!
  before_action :forbid_guestuser, only: [:create, :update, :destroy]

  def index
    @tag = Tag.new
    @tags = Tag.display_show_type("user")
    tags = current_end_user.tags
    @tag_names = []
    if tags.count > 0
      @tag_names = tags.pluck(:name).join(",") + ","
    else
      @tag_names = tags.pluck(:name).join(",")
    end
  end

  def create
    @tag = Tag.new
    tags = params[:tag][:name].split(",")
    if tags.size < 9  && tags.all? { |tag| tag.length < 51 }
      Tag.create_tag(tags, current_end_user)
      @tags = Tag.display_show_type(params[:tag][:model])
    else
      redirect_to request.referer, alert: "タグの追加に失敗しました。追加できるタグは50文字以内、もしくは8個までです。"
    end
    tags = current_end_user.tags
    @tag_names = []
    if tags.count > 0
      @tag_names = tags.pluck(:name).join(",") + ","
    else
      @tag_names = tags.pluck(:name).join(",")
    end
  end

  def update
    @tag = Tag.new
    unless current_end_user.tags.size == 8
      Tag.update_tag(params[:name], current_end_user)
      @tags = Tag.display_show_type(params[:model])
    else
      redirect_to request.referer, alert: "タグの追加に失敗しました。追加できるタグは8個までです。"
    end
    tags = current_end_user.tags
    @tag_names = []
    if tags.count > 0
      @tag_names = tags.pluck(:name).join(",") + ","
    else
      @tag_names = tags.pluck(:name).join(",")
    end
  end

  def destroy
    @tag = Tag.new
    Tag.destroy_tag(params[:name], current_end_user)
    @tags = Tag.display_show_type(params[:model])
    tags = current_end_user.tags
    @tag_names = []
    if tags.count > 0
      @tag_names = tags.pluck(:name).join(",") + ","
    else
      @tag_names = tags.pluck(:name).join(",")
    end
  end
end
