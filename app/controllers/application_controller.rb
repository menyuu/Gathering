class ApplicationController < ActionController::Base


  def user_has_tags?
    unless current_end_user.tags.present? && current_end_user.genres.present? && current_end_user.games.present?
      redirect_to root_path
    end
  end
end
