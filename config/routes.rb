Rails.application.routes.draw do
  resources :universes, only:[:index, :new]
  root 'universes#index'
end
