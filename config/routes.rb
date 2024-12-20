Rails.application.routes.draw do
  get "book/show"
  get "users/new"
  get "static_pages/home"
  get "sessions/new"
  get "reservations/new"
  get "/login", to: "sessions#new"
  get "/logout", to: "sessions#destroy"
  post "/login", to: "sessions#create"
  get "/signup", to: "users#new"
  get "/my_reservations", to: "reservations#my_reservations"
  get "/reservations/by_date", to: "reservations#by_date", as: "reservations_by_date"
  get "/weekly", to: "static_pages#weekly"
  get "/daily", to: "static_pages#daily"

  get "book/:date", to: "book#show", as: "book_date"

  resources :users
  resources :time_slots
  resources :tables
  resources :reservations do
    member do
      patch :cancel
    end
  end

  resources :availabilities, only: [ :index, :create, :destroy, :new ]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "static_pages#home"
end
