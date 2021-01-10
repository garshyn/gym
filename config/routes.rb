# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :trainers do
    resource :authentication, only: :create
    resources :workouts, only: %i[index show create update destroy]
    resources :trainees, only: %i[index]
  end

  namespace :trainees do
    resource :authentication, only: :create
    resources :trainers, only: %i[index] do
      resource :trainer_selection, only: %i[create destroy]
    end
  end
end
