CourseProject::Application.routes.draw do
  resources :shares 
  root to: "main#index"
  resources :posts do
    resources :comments
  end
end
