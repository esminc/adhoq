Adhoq::Engine.routes.draw do
  root to: 'queries#new'

  resources :queries, path: 'q', except: %w(new) do
    resources :executions, only: %w(create show)
  end

  resource  :preview, only: 'create'
end
