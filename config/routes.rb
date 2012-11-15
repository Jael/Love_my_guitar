CourseProject::Application.routes.draw do
  get 'tags/:tag', to: 'posts#index', as: :tag
  get "login" => "sessions#new", as: :log_in
  get "signup" => "users#new", as: :sign_up
  match "logout" => "sessions#destroy", as: :log_out
  resources :shares 
  resources :sessions
  resources :users
  root to: "main#index"

  resources :posts do
    resources :comments
    member{get :vote}
    collection{get :user_post}
  end

end
