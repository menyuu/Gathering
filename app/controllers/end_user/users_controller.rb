class EndUser::UsersController < ApplicationController
  def index
    @users = EndUser.all
  end

  def show
    @user = EndUser.find(params[:id])
  end

  def new
  end

  def edit
  end
end
