class MiddleManager::SelfEvaluationsController < ApplicationController
  before_action :set_middle_manager_self_evaluation, only: [:show, :update, :destroy]

  respond_to :json

  def index
    @middle_manager_self_evaluations = MiddleManager::SelfEvaluation.all
    respond_with(@middle_manager_self_evaluations)
  end

  def show
    respond_with(@middle_manager_self_evaluation)
  end

  def create
    @middle_manager_self_evaluation = MiddleManager::SelfEvaluation.new(middle_manager_self_evaluation_params)
    @middle_manager_self_evaluation.save
    respond_with(@middle_manager_self_evaluation)
  end

  def update
    @middle_manager_self_evaluation.update(middle_manager_self_evaluation_params)
    respond_with(@middle_manager_self_evaluation)
  end

  def destroy
    @middle_manager_self_evaluation.destroy
    respond_with(@middle_manager_self_evaluation)
  end

  private
    def set_middle_manager_self_evaluation
      @middle_manager_self_evaluation = MiddleManager::SelfEvaluation.find(params[:id])
    end

    def middle_manager_self_evaluation_params
      params[:middle_manager_self_evaluation]
    end
end
