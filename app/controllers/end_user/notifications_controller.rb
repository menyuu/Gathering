class EndUser::NotificationsController < ApplicationController
  def update
    current_end_user.passive_notifications.update_all(checked: true)
  end
end
