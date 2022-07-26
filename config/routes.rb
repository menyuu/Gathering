Rails.application.routes.draw do
  devise_for :end_users, path: "users", skip: [:password], controllers: {
    registrations: "end_user/registrations",
    sessions: "end_user/sessions"
  }

  scope module: :end_user do
    root to: "home#top"
    
    resources :users
    resources :tags
  end

  devise_for :admin, skip: [:registrations, :password], controllers: {
    session: "admin/sessions"
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
