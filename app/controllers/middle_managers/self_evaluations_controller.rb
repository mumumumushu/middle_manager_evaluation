class MiddleManagers::SelfEvaluationsController < ApplicationController
  include ActionView::Layouts
  include ActionController::MimeResponds

  acts_as_token_authentication_handler_for User
  before_action :middle_manager?

  before_action :set_self_evaluation, only: [:show, :update]  
  
  respond_to :json
  
  # def index
  #   @self_evaluations = MiddleManager::SelfEvaluation.all
  #   respond_with(@self_evaluations)
  # end

  def show
    respond_with(@self_evaluation)
  end

  # def create
  #   @self_evaluation = MiddleManager::SelfEvaluation.new(self_evaluation_params)
  #   @self_evaluation.save
  #   respond_with(@self_evaluation)
  # end

  def update
    @self_evaluation.update(self_evaluation_params)
    respond_with @self_evaluation, template: "middle_managers/self_evaluations/show", status: 201
  end

  # def destroy
  #   @self_evaluation.destroy
  #   respond_with(@self_evaluation)
  # end

  private

    def middle_manager?
      render json: {
                    error: "用户没有访问权限", 
                    status: 401
                    } ,status: 401 unless current_user.right_type?('middle_manager')
    end

    def set_self_evaluation
      @self_evaluation =  MiddleManager.find(current_user.id).self_evaluation
    end

    def self_evaluation_params
      params.require( :self_evaluation ).permit(
        :duties, :self_evaluation_totality
        )
    end

end
