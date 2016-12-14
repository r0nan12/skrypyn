Rails.application.routes.draw do
  devise_for :users, controllers: { confirmations: 'confirmations' }
  get 'articles/search', to: 'articles#search'
  resources :articles do
    resources :orders, shallow: true
    resources :coments
  end
  resources :orders do
    resources :stripes
    member do
      get 'execute'
      get 'paypals/create', to: 'paypals#create'
    end
  end
  get '/auth/:provider/callback', to: 'auth#create'
  get 'auth/new_email', to: 'auth#new_email'
  post 'auth/new_email', to: 'auth#new_email'
  get 'paypals/execute', to: 'paypals#execute'

  root 'articles#index'
end
