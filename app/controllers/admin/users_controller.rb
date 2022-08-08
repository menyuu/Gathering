class Admin::UsersController < ApplicationController
  def index
    @users = EndUser.page(params[:page]).per(1).order(created_at: :DESC)
  end

  def show
  end

  def edit
  end

  def destroy
    @user = EndUser.find()
  end
end
