Rails.application.routes.draw do


  resources :event, :replace_id_with => 'url'
  resources :meetings

  post 'create' => 'event#create'
  get 'events/create/:id' => 'event#view'
  get 'share/:id/:url' => 'event#share'
  post 'update/:id' => 'event#update'

  root 'meetings#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
