class SelfEvaluationsController < ApplicationController
  before_action :set_self_evaluation, only: [:show, :update, :destroy]

  respond_to :json

  # def index
  #   @self_evaluations = SelfEvaluation.all
  #   respond_with(@self_evaluations)
  # end

  def show
    respond_with(@self_evaluation)
  end

  def create
    @self_evaluation = SelfEvaluation.new(self_evaluation_params)
    @self_evaluation.save
    respond_with(@self_evaluation)

    # User.all.ids.each do |user_id|
    #   @evaluation = Evaluation.new(evaluation_params)
    #   @evaluation.save
      
      
    end

  end

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
      @self_evaluation = SelfEvaluation.find(params[:id])
    end

    def self_evaluation_params
      params[:self_evaluation]
    end
end
