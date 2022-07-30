class EndUser::HomeController < ApplicationController
  def top
    @posts = Post.with_attached_images.order(created_at: :DESC)
    @user = EndUser.new
  end
end
