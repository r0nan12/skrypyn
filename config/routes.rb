Rails.application.routes.draw do

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

   resources :articles do

     resources :coments

   end

   get 'search/show', to: 'search#show'
  get 'search/index', to: 'search#index', as: 'search'
   root 'articles#index'
end
