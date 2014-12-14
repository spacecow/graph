Rails.application.routes.draw do
  resources :universes, only:[:show, :index, :new, :create]
  root 'universes#index'
end
