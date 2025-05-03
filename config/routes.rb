Rails.application.routes.draw do
  # Devise authentication
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users

  # Static pages
  get "home", to: "pages#home"
  get "about", to: "pages#about"
  get "calendar", to: "pages#calendar"
  get "partners", to: "pages#partners"
  get "sponsors", to: "pages#sponsors"
  get "amanah_house", to: "pages#amanah_house"
  get "media_mentions", to: "pages#media_mentions"
  get "leaders", to: "pages#leaders"
  root "pages#home"

  # User-specific routes
  get "/my_registrations", to: "registrations#my_registrations", as: "my_registrations"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  resources :testimonials, only: [ :index, :new, :create ]

  concern :registrable do
    resources :registrations, only: [ :create ]
    resources :payments, only: [ :create ]
  end

  resources :activities, param: :slug, concerns: :registrable
  resources :trips, param: :slug, concerns: :registrable

  # Membership payments (handled at the top level)
  resources :payments, only: [ :create ] do
    collection do
      post :cancel_subscription
    end
  end

  get "/payments/success", to: "payments#success"
  get "/payments/cancel", to: "payments#cancel"
end
