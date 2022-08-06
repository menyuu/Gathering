class EndUser::GroupsController < ApplicationController
  def index
    @groups = Group.includes(:group_tags, :tags, :group_genres, :genres, :group_games, :games, :owner).page(params[:page]).without_count.per(1).order(params[:sort])
    @join_group = current_end_user.groups.includes(:group_tags, :tags, :group_genres, :genres, :group_games, :games, :owner, icon_attachment: [:blob])
  end

  def show
    @group = Group.find(params[:id])
    @group_chat = GroupChat.new
    @member = @group.users
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

  def members
    group = Group.find(params[:group_id])
    @member = group.users
  end

  def group_params
    params.require(:group).permit(:name, :introduction, :icon)
  end
end
