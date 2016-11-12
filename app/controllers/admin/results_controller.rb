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
    respond_with(@result)
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
    respond_with @result, template: "admin/results/show", status: 201
  end

  private
    def set_result
      @result = Result.find(params[:id])
    end

    def result_params
      params.require(:result).permit(:final_result)
    end
end
