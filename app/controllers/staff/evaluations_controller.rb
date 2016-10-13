class Staff::EvaluationsController < ApplicationController
  before_action :set_staff_evaluation, only: [:show, :update, :destroy]

  respond_to :json

  def index
    @staff_evaluations = Staff::Evaluation.all
    respond_with(@staff_evaluations)
  end

  def show
    respond_with(@staff_evaluation)
  end

  def create
    @staff_evaluation = Staff::Evaluation.new(staff_evaluation_params)
    @staff_evaluation.save
    respond_with(@staff_evaluation)
  end

  def update
    @staff_evaluation.update(staff_evaluation_params)
    respond_with(@staff_evaluation)
  end

  def destroy
    @staff_evaluation.destroy
    respond_with(@staff_evaluation)
  end

  private
    def set_staff_evaluation
      @staff_evaluation = Staff::Evaluation.find(params[:id])
    end

    def staff_evaluation_params
      params[:staff_evaluation]
    end
end
