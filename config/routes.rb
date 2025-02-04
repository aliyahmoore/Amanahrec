Rails.application.routes.draw do
  resources :boards
  devise_for :users
  get "pages/home"
  get "pages/about"
  get "pages/calendar"
  get "pages/partners"
  get "pages/board"

  # Health check route
  get "up" => "rails/health#show", as: :rails_health_check

  # PWA files routes
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  resources :media_mentions
  # Defines the root path route ("/")
  # root "posts#index"
  # Define root path
  root "pages#home"

  resources :testimonials, only: [ :index, :new, :create, :edit, :update, :destroy ] do
    member do
      patch :approve
      patch :unapprove
    end
  end

  resources :activities, :events do
    resources :payments, only: [ :create ]
  end

  # Membership payments (handled at the top level)
  resources :payments, only: [ :create ] do
    collection do
      post :cancel_subscription
    end
  end

  get "/payments/success", to: "payments#success"
  get "/payments/cancel", to: "payments#cancel"

  # Activities routes (payment and registration nested under activities)
  resources :activities do
    resources :registrations, only: [ :create ]  # Ensure registrations are nested under activities
    resources :payments, only: [ :create ]       # Ensure payments are nested under activities
  end

  # Events routes (already configured for events)
  resources :events do
    resources :registrations, only: [ :create ]  # Ensure registrations are nested under events
    resources :payments, only: [ :create ]       # Ensure payments are nested under events
  end

get '/my_registrations', to: 'registrations#my_registrations', as: 'my_registrations'


  # Payment success and cancel URLs (if needed globally)
  get "/payments/success", to: "payments#success"
  get "/payments/cancel", to: "payments#cancel"

  # Membership payment routes (assuming it's separate from events/activities)
end
