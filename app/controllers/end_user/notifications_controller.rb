class EndUser::NotificationsController < ApplicationController
  def update
    current_end_user.passive_notifications.each do |notification|
      if notification.checked == false
        notification.update(checked: true)
      end
    end
  end
end
