Rails.application.routes.draw do
  devise_for :end_users, path: "users", skip: [:password], controllers: {
    registrations: "end_user/registrations",
    sessions: "end_user/sessions"
  }

  devise_scope :end_user do
    post "users/sign_up/confirm" => "end_user/registrations#confirm"
    get "users/sign_up/complete" => "end_user/registrations#complete"
  end

  scope module: :end_user do
    root to: "home#top"
    resources :users do
      resource :relationships, only: [:create, :destroy], as: "follows"
      get "followings" => "relationships#followings", as: "followings"
      get "followers" => "relationships#followers", as: "followers"
    end
    resources :posts do
      resources :post_comments, only: [:create, :destroy], as: "comments"
      resource :favorites, only: [:favorite, :create, :destroy]
      collection do
        get "draft"
        get "timeline"
      end
    end
    resources :groups do
      resource :end_user_groups, only: [:create, :destroy], as: "user_groups"
      resources :group_chats, only: [:create, :destroy], as: "chats"
    end

    resources :tags, only: [:index, :create, :update, :destroy]
    resources :games, only: [:index, :create, :update, :destroy]
    resources :genres, only: [:index, :create, :update, :destroy]
  end

  devise_for :admin, skip: [:registrations, :password], controllers: {
    session: "admin/sessions"
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
