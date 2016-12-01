Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations', confirmations: 'confirmations' }
  get 'articles/search', to: 'articles#search'
  resources :articles do
    resources :coments
    end
  get '/auth/:provider/callback', to: 'auth#create'
  root 'articles#index'
end
