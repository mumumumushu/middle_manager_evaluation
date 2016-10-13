class ResultsController < ApplicationController
  before_action :set_admin_result, only: [:show, :update, :set_fina_result]

  respond_to :json

  def index
    @admin_results = Result.all
    respond_with(@admin_results)
  end

  def show
    respond_with(@admin_result)
  end

  # def create
  #   @admin_result = Result.new(admin_result_params)
  #   @admin_result.save
  #   respond_with(@admin_result)
  # end

  def update
    @admin_result.update(admin_result_params)
    respond_with(@admin_result)
  end

  # def destroy
  #   @admin_result.destroy
  #   respond_with(@admin_result)
  # end

  def set_fina_result
    
    
  end

  private
    def set_admin_result
      @admin_result = Result.find(params[:id])
    end

    def admin_result_params
      params[:admin_result]
    end
end
