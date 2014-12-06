Rails.application.routes.draw do
  resources :universes, only: :index
  #root 'welcome#index'
end
