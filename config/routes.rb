# frozen_string_literal: true

Rails.application.routes.draw do
  root 'pages#home'
  get '/tim_kiem', to: 'pages#search', as: 'tim_kiem'

  # For employee
  get 'thong_tin_cong_viec', to: 'employees#work_info'
  get 'thong_tin_ca_nhan', to: 'employees#personal_info'
  get 'thong_tin_hop_dong', to: 'employees#contract_info'
  get 'thong_tin_dong_nghiep', to: 'employees#colleague_info'

  # For document
  get 'tai_lieu_cong_ty', to: 'employees#company_documents'
  get 'tai_lieu_phong_ban', to: 'employees#group_documents'
  get 'tai_lieu_cua_toi', to: 'employees#mine_documents'
  get 'tai_lieu_cong_khai', to: 'documents#public'
  get 'tai_lieu/chi_tiet_tai_lieu/:id', to: 'documents#show', as: 'chi_tiet_tai_lieu'

  # For news
  get 'tin_tuc_cong_ty', to: 'employees#company_news'
  get 'tin_tuc_phong_ban', to: 'employees#group_news'
  get 'tin_tuc_cong_khai', to: 'news#public'
  get 'tin_tuc/chi_tiet_tin_tuc/:id', to: 'news#show', as: 'chi_tiet_tin_tuc'

  # For authentication
  devise_for :administrators
  devise_for :employees,
             path: '',
             path_names: {
               sign_in: 'dang_nhap',
               sign_out: 'dang_xuat',
               edit: 'cap_nhat_thong_tin'
             }

  # For render pdf files
  mount PdfjsViewer::Rails::Engine => '/pdfjs', as: 'pdfjs'
end
