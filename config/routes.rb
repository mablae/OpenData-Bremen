Bremen::Application.routes.draw do
  resources :kitas, only: [:index, :show]

  root to: "pages#index"
end
