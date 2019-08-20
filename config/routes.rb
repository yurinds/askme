# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'users#index'

  resources :users
  resources :sessions, only: %i[new create destroy]
  resources :questions, except: %i[show new index]

  get 'sign_up' => 'users#new'
  get 'log_out' => 'sessions#destroy'
  get 'log_in' => 'sessions#new'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
