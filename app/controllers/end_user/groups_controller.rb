class EndUser::GroupsController < ApplicationController
  before_action :authenticate_end_user!
  before_action :forbid_guestuser, only: [:create, :update, :destroy]

  def index
    @groups = Group.with_attached_icon.page(params[:page]).without_count.per(1).order(created_at: :DESC)
    @join_group = current_end_user.groups.with_attached_icon.includes(:user_groups, users: [icon_attachment: [:blob]], owner: [icon_attachment: [:blob]])
    @group = Group.new
  end

  def show
    @group = Group.find(params[:id])
    @group_chat = GroupChat.new
    @members = @group.users.with_attached_icon.page(params[:page]).without_count.per(1).order(name: :ASC)
  end

  def create
    @group = Group.new(group_params)
    @group.owner_id = current_end_user.id
    if @group.save
      @group.users << current_end_user
    end
    redirect_to group_complete_path(@group), notice: "グループを作成しました。"
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

  def complete
    @group = Group.find(params[:group_id])
    @tags = Tag.display_show_type("group")
    @tag = Tag.new
    @genres = Genre.display_show_type("group")
    @genre = Genre.new
    @games = Game.display_show_type("group")
    @game = Game.new
  end

  private



  def group_params
    params.require(:group).permit(:name, :introduction, :icon)
  end
end
