# frozen_string_literal: true

Rails.application.routes.draw do
  get 'employees/work_info'
  get 'employees/personal_info'
  get 'employees/contract_info'
  get 'employees/colleague_info'
  get 'pages/home'
  devise_for :administrators
  devise_for :employees
  root 'pages#home'
end
