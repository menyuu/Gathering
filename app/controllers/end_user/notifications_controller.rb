class EndUser::NotificationsController < ApplicationController
  def index
    notifications = current_end_user.passive_notifications.page(params[:page]).per(20)
    @notifications = notifications.where.not(visiter_id: current_end_user.id)
  end
  
  def update
    
  end
end
