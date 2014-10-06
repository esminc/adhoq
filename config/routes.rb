Adhoq::Engine.routes.draw do
  root to: 'queries#index'

  resources :queries, path: 'q', except: %w(index)
end
