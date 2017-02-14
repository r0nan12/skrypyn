Rails.application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web, at: '/sidekiq'

  devise_for :users, controllers: { confirmations: 'confirmations' }
  get 'articles/search', to: 'articles#search'
  resources :articles do
    member do
      get 'orders/new',to: 'orders#new'
      post 'orders/create_order', to: 'orders#create_order'
    end
    resources :coments
  end

  get 'orders/success', to: 'orders#success'

  get 'orders/new',to: 'orders#new'
  post 'orders/liqpay', to: 'orders#liqpay'
  post 'orders/stripe', to: 'orders#stripe'
  get 'orders/stripe', to: 'orders#stripe'
  get 'orders/paypal', to: 'orders#paypal'
  post 'orders/paypal', to: 'orders#paypal'
  get 'orders/execute_paypal', to: 'orders#execute_paypal'
  post 'articles/:id', to: 'articles#show'

  get '/auth/:provider/callback', to: 'auth#create'
  get 'auth/new_email', to: 'auth#new_email'
  post 'auth/new_email', to: 'auth#new_email'

  root 'articles#index'
end
