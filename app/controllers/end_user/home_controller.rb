class EndUser::HomeController < ApplicationController
  def top
    @user = EndUser.new
    @posts = Post.with_attached_images.limit(5).order(created_at: :DESC)
  end
end
