Adhoq::Engine.routes.draw do
  root to: 'queries#index'

  resources :queries, path: 'q', except: %w(index) do
    resources :executions, only: %w(create show)
  end

  resource  :preview, only: 'create'
end
