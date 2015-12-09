Rails.application.routes.draw do
  root 'universes#index'

  resources :articles, only:[:show, :new, :create, :edit, :update]
  resources :events, only:[:show, :index, :new, :create, :destroy]
  resources :notes, only:[:show, :new, :create, :edit, :update, :destroy]
  resources :participations, only:[:create]
  resources :references, only:[:show, :create, :edit, :update]
  resources :relations, only:[:show, :create]
  resources :remarks, only:[:create,:edit,:update]
  resources :steps, only:[:create]
  resources :tags, only:[:show, :index, :new, :create]
  resources :taggings, only:[:create]
  resources :universes, only:[:show, :index, :new, :create]
end
