Rails.application.routes.draw do

  root 'universes#index'

  resources :articles, only:[:show,:new,:create,:edit,:update]
  resources :article_mentions, only:[:create,:edit,:update]
  resources :citations, only:[:create]
  resources :events, only:[:show,:index,:new,:create,:edit,:update,:destroy]
  resources :mentions, only:[:create]
  resources :notes, only:[:show,:new,:create,:edit,:update,:destroy]
  resources :participations, only:[:create,:destroy]
  resources :references, only:[:show,:create,:edit,:update]
  resources :relations, only:[:show,:create]
  resources :steps, only:[:create]
  resources :tags, only:[:show,:index,:new,:create,:destroy]
  resources :taggings, only:[:create]
  resources :universes, only:[:show,:index,:new,:create]

end
