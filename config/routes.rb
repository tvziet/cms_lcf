# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :administrators
  devise_for :employees
  root 'pages#home'
  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      resources :groups, only: [:index]
      resources :companies, only: [:index]
    end
  end
end
