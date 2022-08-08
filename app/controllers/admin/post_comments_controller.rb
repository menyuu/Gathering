class Admin::PostCommentsController < ApplicationController
  def destroy
    PostComment.find(params[:id]).destroy
    redirect_to admin_post_path(params[:post_id]), notice: "ユーザーのコメントが正常に削除されました。"
  end
end