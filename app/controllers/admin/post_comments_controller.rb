class Admin::PostCommentsController < ApplicationController
  before_action :login_end_user
  before_action :authenticate_admin!
  
  def destroy
    PostComment.find(params[:id]).destroy
    redirect_to admin_post_path(params[:post_id]), notice: "ユーザーのコメントが正常に削除されました。"
  end
end
