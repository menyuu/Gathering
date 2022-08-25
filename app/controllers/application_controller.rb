class ApplicationController < ActionController::Base

  def forbid_guestuser
    if current_end_user.name == "ゲストユーザー"
      redirect_to posts_path, alert: "ゲストユーザーでは実行できません。"
    end
  end

  def freeze_user
    if current_end_user.freeze?
      sign_out @user
      redirect_to root_path, alert: "アカウントが見つかりません。"
    end
  end
end
