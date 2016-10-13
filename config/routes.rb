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
  devise_for :users, controllers: { sessions: "users/sessions" }
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

#                         Prefix Verb   URI Pattern                                  Controller#Action
#                         apitome        /api/docs                                    Apitome::Engine
#                new_user_session GET    /users/sign_in(.:format)                     devise/sessions#new
#                    user_session POST   /users/sign_in(.:format)                     devise/sessions#create
#            destroy_user_session DELETE /users/sign_out(.:format)                    devise/sessions#destroy
#                   user_password POST   /users/password(.:format)                    devise/passwords#create
#               new_user_password GET    /users/password/new(.:format)                devise/passwords#new
#              edit_user_password GET    /users/password/edit(.:format)               devise/passwords#edit
#                                 PATCH  /users/password(.:format)                    devise/passwords#update
#                                 PUT    /users/password(.:format)                    devise/passwords#update
#        cancel_user_registration GET    /users/cancel(.:format)                      devise/registrations#cancel
#               user_registration POST   /users(.:format)                             devise/registrations#create
#           new_user_registration GET    /users/sign_up(.:format)                     devise/registrations#new
#          edit_user_registration GET    /users/edit(.:format)                        devise/registrations#edit
#                                 PATCH  /users(.:format)                             devise/registrations#update
#                                 PUT    /users(.:format)                             devise/registrations#update
#                                 DELETE /users(.:format)                             devise/registrations#destroy
#               new_admin_session GET    /admins/sign_in(.:format)                    devise/sessions#new
#                   admin_session POST   /admins/sign_in(.:format)                    devise/sessions#create
#           destroy_admin_session DELETE /admins/sign_out(.:format)                   devise/sessions#destroy
#                  admin_password POST   /admins/password(.:format)                   devise/passwords#create
#              new_admin_password GET    /admins/password/new(.:format)               devise/passwords#new
#             edit_admin_password GET    /admins/password/edit(.:format)              devise/passwords#edit
#                                 PATCH  /admins/password(.:format)                   devise/passwords#update
#                                 PUT    /admins/password(.:format)                   devise/passwords#update
#       cancel_admin_registration GET    /admins/cancel(.:format)                     devise/registrations#cancel
#              admin_registration POST   /admins(.:format)                            devise/registrations#create
#          new_admin_registration GET    /admins/sign_up(.:format)                    devise/registrations#new
#         edit_admin_registration GET    /admins/edit(.:format)                       devise/registrations#edit
#                                 PATCH  /admins(.:format)                            devise/registrations#update
#                                 PUT    /admins(.:format)                            devise/registrations#update
#                                 DELETE /admins(.:format)                            devise/registrations#destroy
#              leader_evaluations GET    /leader/evaluations(.:format)                leader/evaluations#index
#               leader_evaluation GET    /leader/evaluations/:id(.:format)            leader/evaluations#show
#                                 PATCH  /leader/evaluations/:id(.:format)            leader/evaluations#update
#                                 PUT    /leader/evaluations/:id(.:format)            leader/evaluations#update
#          staff_evaluation_index GET    /staff/evaluation(.:format)                  staff/evaluation#index
#                staff_evaluation GET    /staff/evaluation/:id(.:format)              staff/evaluation#show
#                                 PATCH  /staff/evaluation/:id(.:format)              staff/evaluation#update
#                                 PUT    /staff/evaluation/:id(.:format)              staff/evaluation#update
#      middle_manager_evaluations GET    /middle_manager/evaluations(.:format)        middle_manager/evaluations#index
#       middle_manager_evaluation GET    /middle_manager/evaluations/:id(.:format)    middle_manager/evaluations#show
#                                 PATCH  /middle_manager/evaluations/:id(.:format)    middle_manager/evaluations#update
#                                 PUT    /middle_manager/evaluations/:id(.:format)    middle_manager/evaluations#update
# middle_manager_slef_evaluations POST   /middle_manager/slef_evaluations(.:format)   middle_manager/slef_evaluations#create
#                                 GET    /middle_manager/slef_evaluations(.:format)   middle_manager/slef_evaluations#show
#                                 PATCH  /middle_manager/slef_evaluations(.:format)   middle_manager/slef_evaluations#update
#                                 PUT    /middle_manager/slef_evaluations(.:format)   middle_manager/slef_evaluations#update
#           middle_manager_result GET    /middle_manager/result(.:format)             middle_manager/results#show
#                                 PATCH  /middle_manager/result(.:format)             middle_manager/results#update
#                                 PUT    /middle_manager/result(.:format)             middle_manager/results#update
#    set_fina_result_admin_result POST   /admin/results/:id/set_fina_result(.:format) admin/results#set_fina_result
#                   admin_results GET    /admin/results(.:format)                     admin/results#index
#                    admin_result GET    /admin/results/:id(.:format)                 admin/results#show

# Routes for Apitome::Engine:
#   root GET  /                         apitome/docs#index
#        GET  /simulate/*path(.:format) apitome/docs#simulate
#        GET  /*path(.:format)          apitome/docs#show
