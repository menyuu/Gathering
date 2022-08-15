class EndUser::RelationshipsController < ApplicationController
  before_action :authenticate_end_user!
  before_action :forbid_guestuser, only: [:create, :destroy]

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
    @users = user.followings.where(status: "published").page(params[:page]).without_count.per(1)
  end

  def followers
    user = EndUser.find(params[:user_id])
    @users = user.followers.where(status: "published").page(params[:page]).without_count.per(1)
  end
end
