# frozen_string_literal: true

Rails.application.routes.draw do
  get 'tai_lieu/chi_tiet_tai_lieu/:id', to: 'documents#show', as: 'chi_tiet_tai_lieu'
  get 'thong_tin_cong_viec', to: 'employees#work_info'
  get 'thong_tin_ca_nhan', to: 'employees#personal_info'
  get 'thong_tin_hop_dong', to: 'employees#contract_info'
  get 'thong_tin_dong_nghiep', to: 'employees#colleague_info'
  get 'tai_lieu_cong_ty', to: 'employees#company_documents'
  get 'tai_lieu_phong_ban', to: 'employees#group_documents'
  get 'tai_lieu_cua_toi', to: 'employees#mine_documents'
  get 'tai_lieu_cong_khai', to: 'documents#public'
  get 'pages/home'
  devise_for :administrators
  devise_for :employees
  root 'pages#home'
end
