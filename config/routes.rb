# frozen_string_literal: true

Rails.application.routes.draw do
  resource :authentication, only: :create
  resources :workouts, only: %i[index show create update destroy]
end
