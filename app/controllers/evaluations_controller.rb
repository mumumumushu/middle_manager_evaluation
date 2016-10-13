class EvaluationsController < ApplicationController
  before_action :set_evaluation, only: [:show, :update, :destroy]

  respond_to :json

  def index
   @evaluations = current_user.evaluations.all
   respond_with(@evaluations)
  end

  def show
    respond_with(@evaluation)
  end

  # def create
  #   @evaluation = Evaluation.new(evaluation_params)
  #   @evaluation.save
  #   respond_with(@evaluation)
  # end

  def update
    @evaluation.update(evaluation_params)
    respond_with(@evaluation)
  end

  # def destroy
  #   @evaluation.destroy
  #   respond_with(@evaluation)
  # end

  private
    def set_evaluation
      @evaluation = current_user.evaluation.find(params[:id])
    end

    def evaluation_params
      params[:evaluation]
    end
end
