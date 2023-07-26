# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users
      resources :registrations, only: %i[create]
      resources :sessions, only: %i[create destroy]
      resources :jogging_times
      resources :reports, only: %i[index]
    end
  end
end
