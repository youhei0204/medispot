# frozen_string_literal: true

Rails.application.routes.draw do
  root  'home_pages#home'
  get   'home_pages/home'
end
