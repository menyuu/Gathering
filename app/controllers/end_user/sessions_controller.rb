# frozen_string_literal: true

class EndUser::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  before_action :user_login_restrictions, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # ゲストユーザー用のアクション
  def guest_sign_in
    # guestメソッドはEndUserモデルで作成
    user = EndUser.guest
    sign_in user
    redirect_to posts_path, notice: "ゲストユーザーでログインしました。"
  end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  def after_sign_in_path_for(resource)
    posts_path
  end

  def user_login_restrictions
    user = EndUser.find_by(email: params[:end_user][:email])
    return if !user
    if user.valid_password?(params[:end_user][:password]) && user.status == "freeze"
      redirect_to new_end_user_registration_path, alert: "アカウントが見つかりません。"
    end
  end
end
