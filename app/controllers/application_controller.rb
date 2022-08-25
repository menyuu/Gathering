class ApplicationController < ActionController::Base
  before_action :freeze_user

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
