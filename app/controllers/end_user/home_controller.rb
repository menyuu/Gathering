class EndUser::HomeController < ApplicationController
  def top
    @user = EndUser.new
    @posts = Post.where(status: "published").with_attached_images.includes(:user).where(user: {status: "published"}).limit(5).order(created_at: :DESC)
  end
end
