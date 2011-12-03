Bremen::Application.routes.draw do
  # Kitas App
  constraints domain: Settings.kitas.host do
    get ':id(/:slug)' => 'kitas#show', as: :kita
    root to: 'kitas#index'
  end
  # Website
  root to: 'pages#index'
end
