class ResultsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_result, only: [:show, :update, :set_fina_result]

  respond_to :json

  def index
    page = params[:page] || 1
    per_page = params[:per_page] || 10
    @results = current_user.results.paginate(page: page, per_page: per_page)
    respond_with(@results)
  end

  def show
    respond_with(@result)
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
    @result.attributes = params.slice(:final_result)
    @result.save 
    respond_with @result, template: "admin/results/show", status: 201
  end

  private
    def set_result
      @result = Result.find(params[:id])
    end

    def result_params
      params[:result]
    end
end
