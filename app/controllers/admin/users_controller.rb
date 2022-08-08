class Admin::UsersController < ApplicationController
  def index
    @users = EndUser.all
  end

  def show
  end

  def edit
  end

  def destroy
  end
end
