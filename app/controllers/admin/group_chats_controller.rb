class Admin::GroupChatsController < ApplicationController
  before_action :login_end_user
  before_action :log_out_user
  before_action :authenticate_admin!

  def index
    @group = Group.find(params[:group_id])
    @members = @group.users.with_attached_icon
    @chats = @group.group_chats.includes(user: [icon_attachment: [:blob]])
  end

  def destroy
    @group = GroupChat.find(params[:id])
    @group.destroy
    group = Group.find(params[:group_id])
    @chats = group.group_chats.includes(:user)
  end
end
