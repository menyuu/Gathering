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
    @user = EndUser.find(params[:user_id])
    users = []
    following_users = @user.followings.with_attached_icon.where(status: "published").includes(:tags, :end_user_tags, :genres, :end_user_genres, :games, :end_user_games)
    users.push(following_users, current_end_user.followings)
    users.flatten!
    users = users.uniq { |user| user.id }
    @users = Kaminari.paginate_array(users).page(params[:page]).per(1)
    @tags = Tag.display_show_type("user")
    common_followings = following_users & current_end_user.followings
    @common_followings = Kaminari.paginate_array(common_followings).page(params[:page]).per(1)
  end

  def followers
    @user = EndUser.find(params[:user_id])
    users = []
    follower_users = @user.followers.where(status: "published")
    users.push(follower_users, current_end_user.followers)
    users.flatten!
    users = users.uniq { |user| user.id }
    @users = Kaminari.paginate_array(users).page(params[:page]).per(1)
    @tags = Tag.display_show_type("user", 15)
  end
end
