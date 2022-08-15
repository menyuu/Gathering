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
    # 空の配列を用意
    users = []
    # @userがフォローしているpublishedユーザーを取得
    following_users = @user.followings.with_attached_icon.where(status: "published").includes(:tags, :end_user_tags, :genres, :end_user_genres, :games, :end_user_games)
    # @userがフォローしているユーザーとcurrent_end_userのフォロワーの重複しているユーザーを取得
    private_users = @user.followings & current_end_user.followings
    # 先ほど変数に代入したユーザーを用意した空の配列に代入
    users.push(following_users, private_users)
    # 一次元配列にする
    users.flatten!
    # 重複したユーザーを除外
    users = users.uniq { |user| user.id }
    @users = Kaminari.paginate_array(users).page(params[:page]).per(1)
    @tags = Tag.display_show_type("user", 15)
    common_followings = users & current_end_user.followings
    @common_followings = Kaminari.paginate_array(common_followings).page(params[:page]).per(1)
  end

  def followers
    @user = EndUser.find(params[:user_id])
    users = []
    follower_users = @user.followers.where(status: "published").includes(:tags, :end_user_tags, :genres, :end_user_genres, :games, :end_user_games)
    private_users = @user.followers & current_end_user.followers
    users.push(follower_users, private_users)
    users.flatten!
    users = users.uniq { |user| user.id }
    @users = Kaminari.paginate_array(users).page(params[:page]).per(1)
    @tags = Tag.display_show_type("user", 15)
    common_followers = users & current_end_user.followers
    @common_followers = Kaminari.paginate_array(common_followers).page(params[:page]).per(1)
  end
end
