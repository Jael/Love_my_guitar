CourseProject::Application.routes.draw do
  get "login" => "sessions#new", as: :log_in
  get "signup" => "users#new", as: :sign_up
  match "logout" => "sessions#destroy", as: :log_out
  resources :shares 
  resources :sessions
  resources :users
  root to: "main#index"
  resources :posts do
    resources :comments
    member do
      get :vote
    end
    collection do
      get :user_post
    end
  end

end
