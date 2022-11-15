class Admin::ChatsController < ApplicationController
  before_action :authenticate_admin!
  def show
    @user = EndUser.find(params[:id])
    @chats = @user.chats
  end

  def destroy
    @chat = Chat.find(params[:id])
    @chat.destroy
    redirect_to request.referer
  end
end
