class MiddleManagers::SelfEvaluationsController < ApplicationController
  before_action :authenticate_middle_manager!
  before_action :set_self_evaluation, only: [:show, :update, :destroy]  
  
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
    respond_with(@self_evaluation)
  end

  # def destroy
  #   @self_evaluation.destroy
  #   respond_with(@self_evaluation)
  # end

  private
    def set_self_evaluation
      @self_evaluation = current_user.self_evaluation
    end

    def self_evaluation_params
      params[:self_evaluation]
    end
end
