Rails.application.routes.draw do

  root 'static_pages#home'

  get '/contact', to: 'static_pages#contact'

  get '/about', to: 'static_pages#about'

  get '/restrict', to: 'static_pages#restrict'

  get '/signup', to: 'users#new'

  post '/signup', to: 'users#create'

  get '/login', to: 'sessions#new'

  post '/login', to: 'sessions#create'

  delete '/logout', to: 'sessions#destroy'

  resources :users

  resources :posts
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
