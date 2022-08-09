class Admin::GroupChatsController < ApplicationController
  def index
    @group = Group.find(params[:group_id])
    @members = @group.users
    @chats = @group.group_chats
  end

  def destroy
    @group = GroupChat.find(params[:id])
    @group.destroy
    redirect_to request.referer
  end
end
