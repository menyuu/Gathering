class EndUser::GroupChatsController < ApplicationController
  before_action :ensure_correct_user

  def index
    @group = Group.find(params[:group_id])
    @group_chat = GroupChat.new
    @members = @group.users.page(params[:page]).without_count.per(1).order(name: :ASC)
    @chats = @group.group_chats.includes(user: [icon_attachment: [:blob]])
  end

  # javascriptと非同期を同時にする方法を模索する
  def create
    @group = Group.find(params[:group_id])
    @group_chat = current_end_user.group_chats.new(chat_params)
    @group_chat.group_id = @group.id
    @chats = @group.group_chats.includes(user: [icon_attachment: [:blob]])
    @members = @group.users.page(params[:page]).without_count.per(1).order(name: :ASC)
    if @group_chat.save
      redirect_to request.referer
    else
      render :index
    end
  end

  def destroy
    @group = Group.find(params[:group_id])
    @group_chat = GroupChat.new
    @destroy_group_chat = GroupChat.find(params[:id])
    @destroy_group_chat.destroy
    @chats = @group.group_chats.includes(user: [icon_attachment: [:blob]])
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
end
