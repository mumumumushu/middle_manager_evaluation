# class MiddleManagers::ResultsController < ApplicationController
#   include ActionView::Layouts
#   include ActionController::MimeResponds

#   acts_as_token_authentication_handler_for User
#   before_action :middle_manager?

#   before_action :had_setted_final_reslut?
#   before_action :set_result, only: [:show]
  
#   respond_to :json

#   # def index
#   #   @results = MiddleManager::Result.all
#   #   respond_with(@results)
#   # end

#   def show
#     respond_with(@result)
#   end

#   # def create
#   #   @result = MiddleManager::Result.new(result_params)
#   #   @result.save
#   #   respond_with(@result)
#   # end

#   # def update
#   #   @result.update(result_params)
#   #   respond_with(@result)
#   # end

#   # def destroy
#   #   @result.destroy
#   #   respond_with(@result)
#   # end

#   private

#     def middle_manager?
#       @error = '用户没有访问权限'
#       render @error, status: 401, 
#               template: "error" unless current_user.right_type?('middle_manager')
#     end
    
#     def set_result
#       @result = MiddleManager.find(current_user.id).self_evaluation.result
#     end
#                             ###################找得到MiddleManager ###找不到它的self_evaluation
#     def had_setted_final_reslut?
#     end

#     # def result_params
#     #   params[:result]
#     # end
# end
