Rails.application.routes.draw do
  get 'listings/new'

  get 'listings/create'

  get 'static_pages/home'

  get 'static_pages/about'

  root 'static_pages#home'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
