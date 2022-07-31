class EndUser::HomeController < ApplicationController
  def top
    @user = EndUser.new
    @posts = Post.with_attached_images.limit(5).order(created_at: :DESC)
    # respond_to do |format|
    #   format.js
    #   format.html
    # end
  end
end
