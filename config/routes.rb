Bremen::Application.routes.draw do
  resources :kitas

  root to: "pages#index"
end
