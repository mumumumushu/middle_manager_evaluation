class MiddleManager::ResultsController < ApplicationController
  before_action :set_middle_manager_result, only: [:show, :update, :destroy]

  respond_to :json

  def index
    @middle_manager_results = MiddleManager::Result.all
    respond_with(@middle_manager_results)
  end

  def show
    respond_with(@middle_manager_result)
  end

  def create
    @middle_manager_result = MiddleManager::Result.new(middle_manager_result_params)
    @middle_manager_result.save
    respond_with(@middle_manager_result)
  end

  def update
    @middle_manager_result.update(middle_manager_result_params)
    respond_with(@middle_manager_result)
  end

  def destroy
    @middle_manager_result.destroy
    respond_with(@middle_manager_result)
  end

  private
    def set_middle_manager_result
      @middle_manager_result = MiddleManager::Result.find(params[:id])
    end

    def middle_manager_result_params
      params[:middle_manager_result]
    end
end
