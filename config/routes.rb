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
  root "pages#home"

  resources :testimonials, only: [ :index, :new, :create, :edit, :update, :destroy ] do
    member do
      patch :approve
      patch :unapprove
    end
  end

  # Activities and Events routes
  resources :activities do
    resources :registrations, only: [ :create ]  # Ensure registrations are nested under activities
    resources :payments, only: [ :new, :create ]  # Ensure payments are nested under activities
  end

  resources :events do
    resources :registrations, only: [ :create ]  # Ensure registrations are nested under events
    resources :payments, only: [ :new, :create ]  # Ensure payments are nested under events
  end

  # Payment success and cancel URLs (if needed globally)
  get "/payments/success", to: "payments#success"
  get "/payments/cancel", to: "payments#cancel"

  # Membership payment routes (assuming it's separate from events/activities)
  resources :payments, only: [ :create ] do
    collection do
      post :cancel_subscription
    end
  end

  get "/my_registrations", to: "registrations#my_registrations", as: "my_registrations"
end
