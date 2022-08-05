class EndUser::GroupMultiToggleController < ApplicationController

  def tags
    @group = Group.find(params[:group_id])
    @tags = Tag.display_show_tags("group")
    @tag = Tag.new
  end

  def create_tags
    @group = Group.find(params[:group_id])
    Tag.create_tag(params[:tag][:name], @group)
    @tags = Tag.display_show_tags(params[:tag][:model])
    @tag = Tag.new
  end

  def update_tags
    @group = Group.find(params[:group_id])
    Tag.update_tag(params[:name], @group)
    @tags = Tag.display_show_tags(params[:model])
    @tag = Tag.new
  end

  def destroy_tags
    @group = Group.find(params[:group_id])
    Tag.destroy_tag(params[:name], @group)
    @tags = Tag.display_show_tags(params[:model])
    @tag = Tag.new
  end











  def genres
    @group = Group.find(params[:group_id])
    @tags = Tag.where(status: "prepared").sort {|a,b| b.groups.size <=> a.groups.size}.first(30)
    @tag = Tag.new
  end

  def games
    @group = Group.find(params[:group_id])
    @tags = Tag.where(status: "prepared").sort {|a,b| b.groups.size <=> a.groups.size}.first(30)
    @tag = Tag.new
  end


end
