Rails.application.routes.draw do
  root 'universes#index'

  resources :articles, only:[:show, :new, :create]
  resources :events, only:[:show]
  resources :notes, only:[:show, :new, :create]
  resources :references, only:[:show, :create, :edit, :update]
  resources :tags, only:[:show, :index, :new, :create]
  resources :taggings, only:[:create]
  resources :universes, only:[:show, :index, :new, :create]
end
