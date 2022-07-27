class EndUser::RelationshipsController < ApplicationController

  def create
    user = EndUser.find(params[:user_id])
    current_end_user.follow(user)
    redirect_to request.referer
  end

  def destroy
    user = EndUser.find(params[:user_id])
    current_end_user.unfollow(user)
    redirect_to request.referer
  end

  def followings
    user = EndUser.find(params[:user_id])
    @users = user.followings
  end

  def followers
    user = EndUser.find(params[:user_id])
    @users = user.followers
  end
end
