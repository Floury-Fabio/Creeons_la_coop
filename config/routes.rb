# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :members
  root 'static_pages#home'
  get 'dashboard', to: "static_pages#dashboard"
  get 'shop', to: "static_pages#shop"

  get 'admin', to: "admin#show"
  post 'admin/delete/:class/:id', to: "admin#destroy"
  post 'admin/role/:role/:id', to: "admin#role"

  resources :missions
  post 'missions/:id/enroll', to: "missions#enroll", as: "enroll_in_mission"
  delete 'missions/:id/enroll', to: "missions#disenroll"

  resources :productors
  resources :infos
  resources :members, only: [:index, :show, :edit, :update]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
