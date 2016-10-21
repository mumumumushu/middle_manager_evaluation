class MiddleManagers::ResultsController < ApplicationController
  include ActionView::Layouts
  include ActionController::MimeResponds

  acts_as_token_authentication_handler_for User
  before_action :middle_manager?

  before_action :had_setted_final_reslut?
  before_action :set_result, only: [:show]
  
  respond_to :json

  # def index
  #   @results = MiddleManager::Result.all
  #   respond_with(@results)
  # end

  def show
    respond_with(@result)
  end

  # def create
  #   @result = MiddleManager::Result.new(result_params)
  #   @result.save
  #   respond_with(@result)
  # end

  # def update
  #   @result.update(result_params)
  #   respond_with(@result)
  # end

  # def destroy
  #   @result.destroy
  #   respond_with(@result)
  # end

  private

    def middle_manager?
      current_user.right_type?('middle_manager')
    end
    
    def set_result
      @result = current_user.self_evaluation.result
    end

    def had_setted_final_reslut?
    end

    # def result_params
    #   params[:result]
    # end
end
