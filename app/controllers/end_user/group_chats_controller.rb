class EndUser::GroupChatsController < ApplicationController
  before_action :authenticate_end_user!
  before_action :ensure_correct_user
  before_action :common_group_chat
  # before_action :forbid_guestuser, only: [:create, :destroy]

  def index
    @group_chat = GroupChat.new
    @members = @group.users.page(params[:page]).without_count.per(1).order(name: :ASC)
  end

  def create
    @group_chat = current_end_user.group_chats.new(chat_params)
    @group_chat.group_id = @group.id
    if @group_chat.save
    else
      render :error
    end
  end

  def destroy
    @destroy_group_chat = GroupChat.find(params[:id])
    @destroy_group_chat.destroy
  end

  private

  def chat_params
    params.require(:group_chat).permit(:text)
  end

  def ensure_correct_user
    group = Group.find(params[:group_id])
    unless group.includesUser?(current_end_user)
      redirect_to group_path(group), alert: "グループのメンバーではありません。"
    end
  end

  def common_group_chat
    @group = Group.find(params[:group_id])
    @chats = @group.group_chats.includes(user: [icon_attachment: [:blob]])
  end
end
