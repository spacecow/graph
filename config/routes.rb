Rails.application.routes.draw do
  resources :universes, only:[:show, :index, :new]
  root 'universes#index'
end
