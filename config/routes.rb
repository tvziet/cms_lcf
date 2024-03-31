# frozen_string_literal: true

Rails.application.routes.draw do
  get 'pages/home'
  devise_for :administrators
  devise_for :employees
  root 'pages#home'
end
