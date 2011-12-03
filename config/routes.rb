Bremen::Application.routes.draw do
  # Kitas App
  constraints domain: Settings.kitas.host do
    get ':id' => 'kitas#show'
    root to: 'kitas#index'
  end
  # Website
  root to: 'pages#index'
end
