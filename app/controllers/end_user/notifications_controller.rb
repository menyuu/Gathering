class EndUser::NotificationsController < ApplicationController
  before_action :login_admin
  before_action :log_out_user


  def update
    current_end_user.passive_notifications.each do |notification|
      if notification.checked == false
        notification.update(checked: true)
      end
    end
  end
end
