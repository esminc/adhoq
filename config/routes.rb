Adhoq::Engine.routes.draw do
  root to: 'queries#new'

  resources :queries, path: 'q', except: %w(new) do
    resources :executions, only: %w(create show)
  end

  resource  :preview,        only: 'create'
  resource  :explain,        only: 'create'
  resources :current_tables, only: 'index'
end
