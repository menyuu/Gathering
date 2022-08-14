class EndUser::GroupsController < ApplicationController
  def index
    @groups = Group.page(params[:page]).without_count.per(1).order(created_at: :DESC)
    @join_group = current_end_user.groups.includes(:group_tags, :tags, :group_genres, :genres, :group_games, :games, :owner, icon_attachment: [:blob])
    @group = Group.new
  end

  def show
    @group = Group.find(params[:id])
    @group_chat = GroupChat.new
    @member = @group.users
  end

  def create
    @group = Group.new(group_params)
    @group.owner_id = current_end_user.id
    if @group.save
      @group.users << current_end_user
    end
    redirect_to group_path(@group), notice: "グループを作成しました。"
  end

  def update
    @group = Group.find(params[:id])
    if @group.update(group_params)
      redirect_to group_path(@group)
    else
      render :edit
    end
  end

  def destroy
    @group = Group.find(params[:id])
    @group.destroy
    redirect_to groups_path
  end

  def members
    group = Group.find(params[:group_id])
    @members = group.users.where(status: "published").page(params[:page]).without_count.per(1)
  end

  private

  def group_params
    params.require(:group).permit(:name, :introduction, :icon)
  end
end
