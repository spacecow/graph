Rails.application.routes.draw do
  root 'universes#index'

  resources :universes, only:[:show, :index, :new, :create]
  resources :articles, only:[:show, :new, :create]
  resources :notes, only:[:show, :new, :create]
  resources :references, only:[:show, :create, :edit, :update]
  resources :tags, only:[:create]
end
