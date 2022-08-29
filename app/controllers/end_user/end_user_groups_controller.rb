class EndUser::EndUserGroupsController < ApplicationController
  before_action :authenticate_end_user!

  def create
    @group = Group.find(params[:group_id])
    user_group = current_end_user.user_groups.new(group_id: @group.id)
    user_group.save
    render "end_user/groups/in_group"
  end

  def destroy
    @group = Group.find(params[:group_id])
    user_group = current_end_user.user_groups.find_by(group_id: @group.id)
    user_group.destroy
    render "end_user/groups/in_group"
  end
end
