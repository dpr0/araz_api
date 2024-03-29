# frozen_string_literal: true

Rails.application.routes.draw do
  apipie
  use_doorkeeper
  devise_for :users, controllers: { omniauth_callbacks: 'callbacks' }

  resources :users
  namespace :api do
    resources :inn,     only: :show
    resources :debtors, only: :show
    resources :fsin,    only: :show
    resources :nalog,   only: :show
    resources :egrul,   only: :show
    resources :arbitr,  only: :show
    resources :video,   only: :index
  end
end
