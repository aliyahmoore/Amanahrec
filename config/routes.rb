Rails.application.routes.draw do
  resources :media_mentions
  resources :boards
  devise_for :users
  get "pages/home"
  get "pages/about"
  get "pages/calendar"
  get "pages/partners"
  get "pages/board"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  get "/about", to: "pages#about"
  # Defines the root path route ("/")
  # root "posts#index"
  root "pages#home"
  resources :testimonials, only: [ :index, :new, :create, :edit, :update, :destroy ] do
    member do
      patch :approve
      patch :unapprove
    end
  end
  resources :events, :activities
end
