Rails.application.routes.draw do
  resources :tasks
  resources :user_projects
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  resources :ideas do
    resources :comments
    member do
      get :addfriend
    end
  end
  resources :comments
  resources :user_projects
  get 'pages/info'
  root to: redirect('/ideas')
  get "pages/info"

  post "/addfriend/:id", to: "ideas#addfriend", method: "post"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
