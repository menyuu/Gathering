class EndUser::FavoritesController < ApplicationController

  def index
    @user = EndUser.find(params[:user_id])
    @posts = @user.favorite_posts.order(created_at: :DESC)
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
