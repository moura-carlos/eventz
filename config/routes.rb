Rails.application.routes.draw do
  resources :categories
  # resources :likes
  # resources :registrations
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

  # here we set up a hierarchy that mimics the hierarchy that we see in the URL.
  # URL => http://some_address_here/events/event_id/registrations
  # registrations only make sense in the context of an event
  resources :events do
    resources :registrations
    resources :likes
  end

  # events/10/registrations is equivalent to the bellow.
  # get 'events/:id/registrations' => 'registrations#index'


  # get 'events/:id/registrations' => 'registrations#index', as: 'event_registrations'
  resources :users

  # because each user will only have one session,
  # we'll use the singular form of the resource.
  resource :session, only: [:new, :create, :destroy]

  get "signup" => "users#new"
  get "signin" => "sessions#new"

  get "events/filter/:filter" => "events#index", as: :filtered_events
end
