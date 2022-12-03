Rails.application.routes.draw do
  resources :registrations
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  #get to: 'events#index'

  root 'events#index'
  # get 'events' => 'events#index'
  # get 'events/new' => 'events#new', as: 'new_event'
  # post 'events' => 'events#create'
  # get 'events/:id' => 'events#show', as: 'event'
  # get 'events/:id/edit' => 'events#edit', as: 'edit_event'
  # patch 'events/:id' => 'events#update' #, as: 'update_event'

  resources :events
end
