class EndUser::FavoritesController < ApplicationController
  before_action :authenticate_end_user!
  before_action :notification_index, only: [:index]

  def index
    freeze_user = EndUser.where(status: "freeze")
    @posts = current_end_user.favorite_posts.where.not(end_user_id: freeze_user).with_attached_images.page(params[:page]).without_count.per(1).order(updated_at: :DESC)
    @post_comment = PostComment.new
    @post_tags = Kaminari.paginate_array(PostingTag.display_show_type("post", 15))
  end

  def create
    @post = Post.find(params[:post_id])
    @favorite = current_end_user.favorites.new(post_id: @post.id)
    if @favorite.save
      @post.create_notification_favorite(current_end_user)
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @favorite = current_end_user.favorites.find_by(post_id: @post.id)
    @favorite.destroy
  end
end
