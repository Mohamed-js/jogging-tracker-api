Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users
      resources :sessions, only: %i[create]
      resources :registrations, only: %i[create]
      resources :jogging_times
      resources :reports, only: %i[index]
    end
  end
end
