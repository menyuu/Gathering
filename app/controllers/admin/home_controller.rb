class Admin::HomeController < ApplicationController
  before_action :login_end_user
  before_action :authenticate_admin!
  
  def top
  end
end
