class Admin::GroupsController < ApplicationController
  def index
    @groups = Group.page(params[:page]).without_count.per(1)
  end

  def show
    @group = Group.find(params[:id])
  end

  def destroy
    @group = Group.find(params[:id])
    @group.destroy
    redirect_to admin_groups_path
  end

  def members
    group = Group.find(params[:group_id])
    @members = group.users.page(params[:page]).without_count.per(1)
  end
end
