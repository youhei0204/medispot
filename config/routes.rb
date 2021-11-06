# frozen_string_literal: true

Rails.application.routes.draw do
  root  'home_pages#home'
  get   'home_pages/home'
  devise_for :users, controllers: {
    confirmations: 'users/confirmations',
    passwords:     'users/passwords',
    registrations: 'users/registrations',
    sessions:      'users/sessions',
  }
  resources :users, only:[:show, :edit, :update]
end
