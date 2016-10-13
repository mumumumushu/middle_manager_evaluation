Rails.application.routes.draw do
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # devise_for :users, controllers: {
  #   sessions: 'user/sessions',
  #   passwords: 'user/passwords'
  # }

  # devise_for :admins, controllers: {
  #   sessions: 'admin/sessions',
  #   passwords: 'admin/passwords', 
  # }

  # devise_for :leaders, controllers: {
  #   sessions: 'leaders/sessions'
  # }

  # devise_for :staffs, controllers: {
  #   sessions: 'staffs/sessions'
  # }

  # devise_for :middle_managers, controllers: {
  #   sessions: 'middle_managers/sessions'
  # }
  devise_for :users
  devise_for :admins

  # resources :evaluations
  # resource :self_evaluations

  namespace :leader do
  	resources :evaluations, only: [ :index, :show, :update ]
  end	

  namespace :staff do
  	resources :evaluation, only: [ :index, :show, :update ]
  end	

  namespace :middle_manager do
  	resources :evaluations, only: [ :index, :show, :update ]
  	resource :slef_evaluations, only: [ :show, :create, :update ]
  	resource :result, only: [ :show, :update ]
  end

  namespace :admin do
  	resources :results, only: [ :index, :show ] do
  		post :set_fina_result, on: :member
		end
  end






end
