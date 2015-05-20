Rails.application.routes.draw do
  root 'universes#index'

  resources :universes, only:[:show, :index, :new, :create]
  resources :articles, only:[:index, :new, :create]
end
