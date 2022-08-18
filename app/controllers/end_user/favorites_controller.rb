class EndUser::FavoritesController < ApplicationController
  before_action :authenticate_end_user!
  before_action :forbid_guestuser, only: [:create, :destroy]

  def index
    @user = EndUser.find(params[:user_id])
    @posts = @user.favorite_posts.with_attached_images.page(params[:page]).without_count.per(1)
    @post_comment = PostComment.new
    @post_tags = Kaminari.paginate_array(PostingTag.display_show_type("post", 15)).page(params[:page]).per(5)
  end

  def create
    @post = Post.find(params[:post_id])
    @favorite = current_end_user.favorites.new(post_id: @post.id)
    @favorite.save
  end

  def destroy
    @post = Post.find(params[:post_id])
    @favorite = current_end_user.favorites.find_by(post_id: @post.id)
    @favorite.destroy
  end
end
