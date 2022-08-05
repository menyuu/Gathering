class EndUser::GroupsController < ApplicationController
  def index
    @groups = Group.includes(:owner, icon_attachment:[:blob])
  end

  def show
    @group = Group.find(params[:id])
    @member = @group.users
    @group_chat = GroupChat.new
    @tags = Tag.all
    @tag = Tag.new
    @genres = Genre.all
    @genre = Genre.new
    @games = Game.all
    @game = Game.new
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.owner_id = current_end_user.id
    if @group.save!
      @group.users << current_end_user
      redirect_to group_path(@group)
    else
      render :new
    end
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])
    if @group.update(group_params)
      redirect_to group_path(@group)
    else
      render :edit
    end
  end

  def gtoup_tags
    @tags = Tag.where(status: "prepared").sort {|a,b| b.groups.size <=> a.groups.size}.first(30)
    @tag = Tag.new
  end

  def group_genres
    @tags = Tag.where(status: "prepared").sort {|a,b| b.groups.size <=> a.groups.size}.first(30)
    @tag = Tag.new
  end

  def group_games
    @tags = Tag.where(status: "prepared").sort {|a,b| b.groups.size <=> a.groups.size}.first(30)
    @tag = Tag.new
  end

  def members
    group = Group.find(params[:group_id])
    @member = group.users
  end

  def group_params
    params.require(:group).permit(:name, :introduction, :icon)
  end
end
