Rails.application.routes.draw do
  
  # devise_for :users#, controllers: { sessions: "users/sessions" }
 

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # devise_for :users, controllers: {
  #   sessions: 'user/sessions',
  #   passwords: 'user/passwords'
  # }

  # devise_for :admins, controllers: {
  #   sessions: 'admin/sessions',
  #   passwords: 'admin/passwords', 
  # }

  # devise_for :leaders
  # , controllers: {
  #   sessions: 'leaders/sessions'
  # }

###？？？？？？？？user？？？？？？会无法验证
  devise_for :users
  # devise_for :leaders
  # devise_for :staffs
  # devise_for :middle_managers
  devise_for :admins

  # resources :evaluations
  # resource :self_evaluations

  namespace :leaders do
  	resources :evaluations, only: [ :index, :show, :update ]
  end	

  namespace :staffs do
  	resources :evaluations, only: [ :index, :show, :update ]
  end	

  namespace :middle_managers do
  	resources :evaluations, only: [ :index, :show, :update ]
  	resource :self_evaluation, only: [ :show, :create, :update ]
  	resource :result, only: [ :show ]
  end

  namespace :admin do
  	resources :results, only: [ :index, :show ] do
  		patch :set_final_result, on: :member
      get :feedback_form, on: :member
		end
    resources :activities, only: [:index, :show, :create, :update]
	end
  
  resource :user_info, only: [:show]
	
end

#                          Prefix Verb   URI Pattern                                   Controller#Action
#                         apitome        /api/docs                                     Apitome::Engine
#                new_user_session GET    /users/sign_in(.:format)                      devise/sessions#new
#                    user_session POST   /users/sign_in(.:format)                      devise/sessions#create
#            destroy_user_session DELETE /users/sign_out(.:format)                     devise/sessions#destroy
#                   user_password POST   /users/password(.:format)                     devise/passwords#create
#               new_user_password GET    /users/password/new(.:format)                 devise/passwords#new
#              edit_user_password GET    /users/password/edit(.:format)                devise/passwords#edit
#                                 PATCH  /users/password(.:format)                     devise/passwords#update
#                                 PUT    /users/password(.:format)                     devise/passwords#update
#        cancel_user_registration GET    /users/cancel(.:format)                       devise/registrations#cancel
#               user_registration POST   /users(.:format)                              devise/registrations#create
#           new_user_registration GET    /users/sign_up(.:format)                      devise/registrations#new
#          edit_user_registration GET    /users/edit(.:format)                         devise/registrations#edit
#                                 PATCH  /users(.:format)                              devise/registrations#update
#                                 PUT    /users(.:format)                              devise/registrations#update
#                                 DELETE /users(.:format)                              devise/registrations#destroy
#               new_admin_session GET    /admins/sign_in(.:format)                     devise/sessions#new
#                   admin_session POST   /admins/sign_in(.:format)                     devise/sessions#create
#           destroy_admin_session DELETE /admins/sign_out(.:format)                    devise/sessions#destroy
#                  admin_password POST   /admins/password(.:format)                    devise/passwords#create
#              new_admin_password GET    /admins/password/new(.:format)                devise/passwords#new
#             edit_admin_password GET    /admins/password/edit(.:format)               devise/passwords#edit
#                                 PATCH  /admins/password(.:format)                    devise/passwords#update
#                                 PUT    /admins/password(.:format)                    devise/passwords#update
#       cancel_admin_registration GET    /admins/cancel(.:format)                      devise/registrations#cancel
#              admin_registration POST   /admins(.:format)                             devise/registrations#create
#          new_admin_registration GET    /admins/sign_up(.:format)                     devise/registrations#new
#         edit_admin_registration GET    /admins/edit(.:format)                        devise/registrations#edit
#                                 PATCH  /admins(.:format)                             devise/registrations#update
#                                 PUT    /admins(.:format)                             devise/registrations#update
#                                 DELETE /admins(.:format)                             devise/registrations#destroy
#             leaders_evaluations GET    /leaders/evaluations(.:format)                leaders/evaluations#index
#              leaders_evaluation GET    /leaders/evaluations/:id(.:format)            leaders/evaluations#show
#                                 PATCH  /leaders/evaluations/:id(.:format)            leaders/evaluations#update
#                                 PUT    /leaders/evaluations/:id(.:format)            leaders/evaluations#update
#              staffs_evaluations GET    /staffs/evaluations(.:format)                 staffs/evaluations#index
#               staffs_evaluation GET    /staffs/evaluations/:id(.:format)             staffs/evaluations#show
#                                 PATCH  /staffs/evaluations/:id(.:format)             staffs/evaluations#update
#                                 PUT    /staffs/evaluations/:id(.:format)             staffs/evaluations#update
#     middle_managers_evaluations GET    /middle_managers/evaluations(.:format)        middle_managers/evaluations#index
#      middle_managers_evaluation GET    /middle_managers/evaluations/:id(.:format)    middle_managers/evaluations#show
#                                 PATCH  /middle_managers/evaluations/:id(.:format)    middle_managers/evaluations#update
#                                 PUT    /middle_managers/evaluations/:id(.:format)    middle_managers/evaluations#update
# middle_managers_self_evaluation POST   /middle_managers/self_evaluation(.:format)    middle_managers/self_evaluations#create
#                                 GET    /middle_managers/self_evaluation(.:format)    middle_managers/self_evaluations#show
#                                 PATCH  /middle_managers/self_evaluation(.:format)    middle_managers/self_evaluations#update
#                                 PUT    /middle_managers/self_evaluation(.:format)    middle_managers/self_evaluations#update
#          middle_managers_result GET    /middle_managers/result(.:format)             middle_managers/results#show
#   set_final_result_admin_result PATCH  /admin/results/:id/set_final_result(.:format) admin/results#set_final_result
#                   admin_results GET    /admin/results(.:format)                      admin/results#index
#                    admin_result GET    /admin/results/:id(.:format)                  admin/results#show
#                activitise_index GET    /activitise(.:format)                         activitise#index
#                                 POST   /activitise(.:format)                         activitise#create
#                      activitise GET    /activitise/:id(.:format)                     activitise#show
#                                 PATCH  /activitise/:id(.:format)                     activitise#update
#                                 PUT    /activitise/:id(.:format)                     activitise#update
#                                 DELETE /activitise/:id(.:format)                     activitise#destroy
#                       user_info GET    /user_info(.:format)                          user_infos#show

# Routes for Apitome::Engine:
#   root GET  /                         apitome/docs#index
#        GET  /simulate/*path(.:format) apitome/docs#simulate
#        GET  /*path(.:format)          apitome/docs#show