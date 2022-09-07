Rails.application.routes.draw do
  devise_for :end_users, skip: [:passwords], path: "users", controllers: {
    registrations: "end_user/registrations",
    sessions: "end_user/sessions"
  }

  devise_scope :end_user do
    get "users/sign_up/complete" => "end_user/registrations#complete"
    post "users/guest_sign_in" => "end_user/sessions#guest_sign_in"
  end

  get "users" => "end_user/users#dummy"

  scope module: :end_user do
    root to: "home#top"
    resources :users, only: [:show, :update] do
      resource :relationships, only: [:create, :destroy], as: "follows"
      get "followings" => "relationships#followings", as: "followings"
      get "followers" => "relationships#followers", as: "followers"
      get "favorite" => "favorites#index", as: "favorites"
      member do
        patch "open" => "users#open_user"
        patch "close" => "users#close_user"
      end
    end
    resources :posts, except: [:new, :edit] do
      resources :post_comments, only: [:create, :destroy], as: "comments"
      resource :favorites, only: [:create, :destroy]
      resource :posting_tags, only: [:show, :create, :update, :destroy], as: "tags"
      collection do
        get "draft"
        get "index_all"
      end
    end
    resources :groups, except: [:edit, :new] do
      resource :end_user_groups, only: [:create, :destroy], as: "user_groups"
      resources :group_chats, only: [:index, :create, :destroy], as: "chats"
      get "tags" => "group_multi_toggle"
      post "create_tags" => "group_multi_toggle"
      patch "update_tags" => "group_multi_toggle"
      delete "destroy_tags" => "group_multi_toggle"
      get "genres" => "group_multi_toggle"
      post "create_genres" => "group_multi_toggle"
      patch "update_genres" => "group_multi_toggle"
      delete "destroy_genres" => "group_multi_toggle"
      get "games" => "group_multi_toggle"
      post "create_games" => "group_multi_toggle"
      patch "update_games" => "group_multi_toggle"
      delete "destroy_games" => "group_multi_toggle"
      get "complete" => "group_multi_toggle"
      get "user_join_groups", as: "user_join", on: :collection
    end
    resources :tags, only: [:index, :create, :update, :destroy]
    resources :games, only: [:index, :create, :update, :destroy]
    resources :genres, only: [:index, :create, :update, :destroy]
    get "search" => "searches#search"
  end

  devise_for :admin, skip: [:registrations, :password], controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    get "/" => "home#top"
    resources :posts, only: [:index, :show, :destroy] do
      resources :post_comments, only: [:destroy], as: "comment"
    end
    resources :users, only: [:index, :show, :update, :destroy] do
      patch "freeze", on: :member
    end
    resources :groups, only: [:index, :show, :destroy] do
      resources :group_chats, only: [:index, :destroy], as: "chats"
      get "members"
    end
    resources :tags, only: [:index, :create, :update, :destroy] do
      get "search", on: :collection
    end
    resources :genres, only: [:index, :create, :update, :destroy] do
      get "search", on: :collection
    end
    resources :games, only: [:index, :create, :update, :destroy] do
      get "search", on: :collection
    end
    resources :posting_tags, only: [:index, :destroy], as: "post_tags" do
      get "search", on: :collection
    end
    get "search" => "searches#search"
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
