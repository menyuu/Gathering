class EndUser::EndUserGroupsController < ApplicationController
  def create
    user_group = current_end_user.user_groups.new(group_id: params[:group_id])
    user_group.save
    redirect_to request.referer, notice: "グループに参加しました。"
  end

  def destroy
    user_group = current_end_user.user_groups.find_by(group_id: params[:group_id])
    user_group.destroy
    redirect_to request.referer, alert: "グループから脱退しました。"
  end
end
