Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  resources :ideas do
    member do
        get :addfriend
    end
  end
  resources :comments
  get 'pages/info'
  root to: redirect('/ideas')
  get "pages/info"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
