Rails.application.routes.draw do
  devise_for :end_users, path: "users", controllers: {
    registrations: "end_user/registrations",
    sessions: "end_user/sessions",
    passwords: "end_user/passwords"
  }

  devise_scope :end_user do
    post "users/sign_up/confirm" => "end_user/registrations#confirm"
    get "users/sign_up/complete" => "end_user/registrations#complete"
  end

  scope module: :end_user do
    root to: "home#top"
    resources :users, except: [:new] do
      resource :relationships, only: [:create, :destroy], as: "follows"
      get "followings" => "relationships#followings", as: "followings"
      get "followers" => "relationships#followers", as: "followers"
      get "favorite" => "favorites#index", as: "favorites"
      member do
        patch "open" => "users#open_user"
        patch "close" => "users#close_user"
      end
    end
    resources :posts, except: [:new] do
      resources :post_comments, only: [:create, :destroy], as: "comments"
      resource :favorites, only: [:create, :destroy]
      resources :posting_tags, only: [:create, :update, :destroy], as: "tags"
      # get ""
      collection do
        get "draft"
        get "index_all"
      end
    end
    resources :groups do
      resource :end_user_groups, only: [:create, :destroy], as: "user_groups"
      resources :group_chats, only: [:create, :destroy], as: "chats"
    end
    resources :tags, only: [:index, :create, :update, :destroy]
    resources :games, only: [:index, :create, :update, :destroy]
    resources :genres, only: [:index, :create, :update, :destroy]
    get "search" => "searches#search"
  end

  devise_for :admin, skip: [:registrations, :password], controllers: {
    session: "admin/sessions"
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
