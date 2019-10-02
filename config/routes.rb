# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'users#index'

  resource :session, only: %i[new create destroy]

  resources :users
  resources :hashtags, only: %i[show]
  resources :questions, except: %i[show new index]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
