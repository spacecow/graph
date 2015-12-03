Rails.application.routes.draw do
  root 'universes#index'

  resources :articles, only:[:show, :new, :create]
  resources :events, only:[:show, :index, :new, :create, :destroy]
  resources :notes, only:[:show, :new, :create, :edit, :update, :destroy]
  resources :participations, only:[:create]
  resources :references, only:[:show, :create, :edit, :update]
  resources :relations, only:[:show, :create]
  resources :steps, only:[:create]
  resources :tags, only:[:show, :index, :new, :create]
  resources :taggings, only:[:create]
  resources :universes, only:[:show, :index, :new, :create]
end
