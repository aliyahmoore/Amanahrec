Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :boards
  devise_for :users
  get "pages/home"
  get "pages/about"
  get "pages/calendar"
  get "pages/partners"
  get "pages/board"
  get "/my_registrations", to: "registrations#my_registrations", as: "my_registrations"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
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

  concern :registrable do
    resources :registrations, only: [ :create ]
    resources :payments, only: [ :create ]
  end

  resources :activities, param: :slug, concerns: :registrable
  resources :events, param: :slug, concerns: :registrable

  # Membership payments (handled at the top level)
  resources :payments, only: [ :create ] do
    collection do
      post :cancel_subscription
    end
  end

  get "/payments/success", to: "payments#success"
  get "/payments/cancel", to: "payments#cancel"
end
