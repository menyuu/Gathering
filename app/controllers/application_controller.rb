class ApplicationController < ActionController::Base
  def user_has_tags?
    unless current_end_user.tags.present? && current_end_user.genres.present? && current_end_user.games.present?
      flash[:notice] = "タグもしくはジャンル、ゲームが設定されていません。"
      # リダイレクト先を設定する
    end
  end
end
