class Admin::GroupChatsController < ApplicationController
  def index
    @group = Group.find(params[:group_id])
    @members = @group.users.with_attached_icon
    @chats = @group.group_chats.includes(:user)
  end

  def destroy
    @group = GroupChat.find(params[:id])
    @group.destroy
    redirect_to request.referer
  end
end
