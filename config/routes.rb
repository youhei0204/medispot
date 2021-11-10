# frozen_string_literal: true

Rails.application.routes.draw do
  root  'home_pages#home'
  get   'home_pages/home'
  get   '/map_request', to: 'maps#map', as: 'map_request'
  devise_for :users, controllers: {
    confirmations: 'users/confirmations',
    passwords:     'users/passwords',
    registrations: 'users/registrations',
    sessions:      'users/sessions',
  }
  resources :users, only:[:show, :edit, :update]
  resources :spots, only:[:show, :index]
  resources :reviews
end
