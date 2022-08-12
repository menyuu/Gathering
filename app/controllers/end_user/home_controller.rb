class EndUser::HomeController < ApplicationController
  before_action :user_after_signed_in_prohibit

  def top
    @user = EndUser.new
    @posts = Post.where(status: "published").with_attached_images.includes(:post_tags, :tags, user: [icon_attachment: [:blob]]).where(user: {status: "published"}).limit(5).order(created_at: :DESC)
  end

  def user_after_signed_in_prohibit
    if current_end_user
      flash[:notice] = "すでにログインしています。"
      # リダイレクト先を作る
    end
  end
end
