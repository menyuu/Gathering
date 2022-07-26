class EndUser::ChatsController < ApplicationController
  before_action :reject_non_related, only: [:show]
  before_action :notification_index, only: [:show]

  def show
    @user = EndUser.find(params[:id])
    rooms = current_end_user.end_user_rooms.pluck(:room_id)
    # 選択したユーザーがログイン中のユーザーと同じルームを持っているかを判定
    user_rooms = EndUserRoom.find_by(end_user_id: @user.id, room_id: rooms)

    if user_rooms
      @room = user_rooms.room
    else
      @room = Room.new
      @room.save
      EndUserRoom.create(end_user_id: current_end_user.id, room_id: @room.id)
      EndUserRoom.create(end_user_id: @user.id, room_id: @room.id)
    end
    @chats = @room.chats
    @chat = Chat.new(room_id: @room.id)
  end

  def create
    @chat = current_end_user.chats.new(chat_params)
    room = @chat.room_id
    room = EndUserRoom.find_by(end_user_id: current_end_user, room_id: room)
    room = room.room
    @chats = room.chats
    unless @chat.save
      render :error
    end
  end

  private
  def chat_params
    params.require(:chat).permit(:message, :room_id)
  end

  def reject_non_related
    user = EndUser.find(params[:id])
    # ログイン中のユーザーがフォロワー同士であるかを判定
    unless current_end_user.following?(user) && user.following?(current_end_user)
      redirect_to user_path(user)
    end
  end
end
