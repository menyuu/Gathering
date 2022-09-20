class ApplicationController < ActionController::Base
  before_action :freeze_user

  def login_admin
    if admin_signed_in?
      redirect_to admin_path, alert: "管理者でログイン中です。"
    end
  end

  def login_end_user
    if end_user_signed_in?
      redirect_to posts_path, alert: "ユーザーでログイン中です。"
    end
  end

  def notification_index
    notifications = current_end_user.passive_notifications.page(params[:page]).per(5)
    @notifications = notifications.where.not(visiter_id: current_end_user.id)
  end

  def forbid_guestuser
    if current_end_user.name == "ゲストユーザー"
      redirect_to posts_path, alert: "ゲストユーザーでは実行できません。"
    end
  end

  def freeze_user
    if end_user_signed_in? && current_end_user.freeze?
      sign_out current_end_user
      redirect_to root_path, alert: "アカウントが見つかりません。"
    end
  end
end
