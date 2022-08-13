class ApplicationController < ActionController::Base

  def forbid_guestuser_posting
    if current_end_user.name == "ゲストユーザー"
      redirect_to posts_path, alert: "ゲストユーザーでは実行できません。"
    end
  end
end
