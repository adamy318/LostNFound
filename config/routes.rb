Rails.application.routes.draw do
  get 'about', to: 'static_pages#about'

  get 'signup', to: 'static_pages#signup'

  get 'login', to: 'static_pages#login'

  root 'static_pages#home'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
