class MiddleManager::EvaluationsController < ApplicationController
  before_action :set_middle_manager_evaluation, only: [:show, :update, :destroy]

  respond_to :json

  def index
    @middle_manager_evaluations = MiddleManager::Evaluation.all
    respond_with(@middle_manager_evaluations)
  end

  def show
    respond_with(@middle_manager_evaluation)
  end

  def create
    @middle_manager_evaluation = MiddleManager::Evaluation.new(middle_manager_evaluation_params)
    @middle_manager_evaluation.save
    respond_with(@middle_manager_evaluation)
  end

  def update
    @middle_manager_evaluation.update(middle_manager_evaluation_params)
    respond_with(@middle_manager_evaluation)
  end

  def destroy
    @middle_manager_evaluation.destroy
    respond_with(@middle_manager_evaluation)
  end

  private
    def set_middle_manager_evaluation
      @middle_manager_evaluation = MiddleManager::Evaluation.find(params[:id])
    end

    def middle_manager_evaluation_params
      params[:middle_manager_evaluation]
    end
end
