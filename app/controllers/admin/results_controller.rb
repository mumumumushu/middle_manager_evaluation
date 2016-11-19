class Admin::ResultsController < ApplicationController
  include ActionView::Layouts
  include ActionController::MimeResponds

  acts_as_token_authentication_handler_for Admin
  before_action :set_result, only: [:show, :feedback_form, :set_fina_result]

  respond_to :json

  def index
    @results = Result.where(activity_year: params[:activity_year])
    respond_with(@results)
  end

  def show
    @evaluations = Evaluation.where(self_evaluation: @result.self_evaluation)
    @leader_evaluations = @evaluations.evaluated_by('leader')
    @middle_manager_evaluations = @evaluations.evaluated_by('middle_manager')
    @staff_evaluations = @evaluations.evaluated_by('staff')
    respond_with(
      @result, @evaluations, @leader_evaluations, 
      @middle_manager_evaluations, @middle_manager_evaluations
      )
  end

  def feedback_form
    respond_with (@result)
  end

  # def create
  #   @result = Result.new(result_params)
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

  def set_final_result
    @result = Result.find(params[:id])
    @result.update(result_params)
    @result.final_evaluation_time = Time.now
    @result.save
    respond_with @result, template: "admin/results/feedback_form", status: 201
  end

  private
    def set_result
      @result = Result.find(params[:id])
    end

    def result_params
      params.require(:result).permit(:final_result)
    end
end
