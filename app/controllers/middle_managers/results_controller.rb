class MiddleManagers::ResultsController < ApplicationController
  include ActionView::Layouts
  include ActionController::MimeResponds

  acts_as_token_authentication_handler_for User
  before_action :set_result, only: [:show]
  
  respond_to :json

  # def index
  #   @results = MiddleManager::Result.all
  #   respond_with(@results)
  # end

  def show
    respond_with(@result)
  end

  # def create
  #   @result = MiddleManager::Result.new(result_params)
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

  private
    def set_result
      @result = current_user.result
    end

    # def result_params
    #   params[:result]
    # end
end
