class Admin::ResultsController < ApplicationController
  include ActionView::Layouts
  include ActionController::MimeResponds

  acts_as_token_authentication_handler_for Admin
  before_action :set_result, only: [:show, :feedback_form, :set_final_result, :set_average_level]

  respond_to :json

  def index
    # page = params[:page] || 1
    # per_page = params[:per_page] || 10
    @results = Result.where(activity_year: params[:activity_year]#).paginate(page: page, per_page: per_page)
    respond_with(@results)
  end

  def show
    @evaluations = Evaluation.where(self_evaluation: @result.self_evaluation)
    @leader_evaluations = @evaluations.evaluated_by('领导')
    @middle_manager_evaluations = @evaluations.evaluated_by('中层干部')
    @staff_evaluations = @evaluations.evaluated_by('职工')
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

  def set_average_level
    @result.update(average_level_params)
    @result.save
    render nothing: true, status: 201
  end

  def set_final_result
    @result.update(result_params)
    @result.final_evaluation_time = Time.now
    @result.save
    render nothing: true, status: 201
  end

  private
    def set_result
      @result = Result.find(params[:id])
    end

    def result_params
      params.require(:result).permit(:final_result)
    end

    def average_level_params
      params.require(:result).permit(:average_level_by_setting)
    end
end
