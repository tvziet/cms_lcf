# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :administrators
  devise_for :employees
  root 'pages#home'
end
