class Leader::EvaluationsController < ApplicationController
  before_action :set_leader_evaluation, only: [:show, :update, :destroy]

  respond_to :json

  def index
    @leader_evaluations = Leader::Evaluation.all
    respond_with(@leader_evaluations)
  end

  def show
    respond_with(@leader_evaluation)
  end

  def create
    @leader_evaluation = Leader::Evaluation.new(leader_evaluation_params)
    @leader_evaluation.save
    respond_with(@leader_evaluation)
  end

  def update
    @leader_evaluation.update(leader_evaluation_params)
    respond_with(@leader_evaluation)
  end

  def destroy
    @leader_evaluation.destroy
    respond_with(@leader_evaluation)
  end

  private
    def set_leader_evaluation
      @leader_evaluation = Leader::Evaluation.find(params[:id])
    end

    def leader_evaluation_params
      params[:leader_evaluation]
    end
end
