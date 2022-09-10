class EndUser::RelationshipsController < ApplicationController
  before_action :authenticate_end_user!
  before_action :ensure_correct_user, only: [:create]

  def create
    @user = EndUser.find(params[:user_id])
    current_end_user.follow(@user)
    @user.create_notification_follow(current_end_user)
  end

  def destroy
    @user = EndUser.find(params[:user_id])
    current_end_user.unfollow(@user)
  end

  def followings
    @user = EndUser.find(params[:user_id])
    # 空の配列を用意
    users = []
    # @userがフォローしているpublishedユーザーを取得
    following_users = @user.followings.with_attached_icon.where(status: "published")
    # @userがフォローしているユーザーとcurrent_end_userのフォロワーの重複しているユーザーを取得
    private_users = @user.followings & current_end_user.followings
    # 先ほど変数に代入したユーザーを用意した空の配列に代入
    users.push(following_users, private_users)
    # 一次元配列にする
    users.flatten!
    # 重複したユーザーを除外
    users = users.uniq { |user| user.id }
    @users = Kaminari.paginate_array(users).page(params[:page]).per(1)
    @post_tags = PostingTag.display_show_type("post")
    common_followings = users & current_end_user.followings
    @common_followings = Kaminari.paginate_array(common_followings)
  end

  def followers
    @user = EndUser.find(params[:user_id])
    users = []
    # パブリックユーザーを取得する
    follower_users = @user.followers.with_attached_icon.where(status: "published")
    # ページのユーザーとログイン中のユーザーのフォロワーで重複したものを変数に代入する
    private_users = @user.followers.with_attached_icon & current_end_user.followers.where.not(status: "freeze")
    # 上記の2つを配列に代入する
    users.push(follower_users, private_users)
    # ページのユーザーにログイン中のユーザーが存在すればusersの配列に代入する
    if @user.followers.include?(current_end_user)
      users << current_end_user
    end
    # 1次元配列にする
    users.flatten!
    # idの重複するデータを
    users = users.uniq { |user| user.id }
    @users = Kaminari.paginate_array(users).page(params[:page]).per(1)
    @post_tags = PostingTag.display_show_type("post")
    following_users = @user.followers.with_attached_icon.where(status: "published")
    private_users = @user.followers & current_end_user.followings.where.not(status: "freeze")
    users.push(following_users, private_users)
    users.flatten!
    users = users.uniq { |user| user.id }
    common_followings = users & current_end_user.followings
    @common_followings = Kaminari.paginate_array(common_followings)
  end

  private

  def ensure_correct_user
    user = EndUser.find(params[:user_id])
    if user.name == "ゲストユーザー"
      redirect_to request.referer, alert: "ゲストユーザーはフォローできません。"
    end
  end
end
