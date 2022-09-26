class Admin::GroupsController < ApplicationController
  before_action :login_end_user
  before_action :log_out_user
  before_action :authenticate_admin!

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

  def destroy
    @group = Group.find(params[:id])
    @group.destroy
    redirect_to admin_groups_path
  end
end
