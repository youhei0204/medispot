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
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end
  resources :users, only:[:show, :edit, :update] do
    resources :notifications, only:[:show, :index]
  end
  resources :spots, only:[:show, :index] do
    resources :favorites, only:[:create, :destroy]
  end
  resources :reviews do
    resources :likes, only:[:create, :destroy]
  end
end
