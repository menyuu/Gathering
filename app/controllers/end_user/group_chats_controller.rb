class EndUser::GroupChatsController < ApplicationController
  def index
    @group = Group.find(params[:group_id])
    @group_chat = GroupChat.new
    @members = @group.users.page(params[:page]).without_count.per(1).order(name: :ASC)
    @chats = @group.group_chats.includes(user: [icon_attachment: [:blob]])
  end

  def create
    group = Group.find(params[:group_id])
    group_chat = current_end_user.group_chats.new(chat_params)
    group_chat.group_id = group.id
    group_chat.save
    redirect_to group_chats_path(group)
  end

  def destroy
    @group = GroupChat.find(params[:id])
    @group.destroy
    redirect_to request.referer
  end

  private

  def chat_params
    params.require(:group_chat).permit(:text)
  end
end
