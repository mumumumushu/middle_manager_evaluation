class MiddleManagers::SelfEvaluationsController < ApplicationController
  include ActionView::Layouts
  include ActionController::MimeResponds

  acts_as_token_authentication_handler_for User
  before_action :middle_manager?

  before_action :set_self_evaluation, only: [:show, :update]  
  
  respond_to :json
  
  # def index
  #   @self_evaluations = MiddleManager::SelfEvaluation.all
  #   respond_with(@self_evaluations)
  # end

  def show
    respond_with(@self_evaluation)
  end

  # def create
  #   @self_evaluation = MiddleManager::SelfEvaluation.new(self_evaluation_params)
  #   @self_evaluation.save
  #   respond_with(@self_evaluation)
  # end

  def update
    @self_evaluation.middle_manager.user_info.update(user_info_params)
    @self_evaluation.update(self_evaluation_params)#更新user_info 更新self_evaluation备份数据
    respond_with @self_evaluation, template: "middle_managers/self_evaluations/show", status: 201
  end

  # def destroy
  #   @self_evaluation.destroy
  #   respond_with(@self_evaluation)
  # end

  private

    def middle_manager?
      @error = '用户没有访问权限'
      render @error, status: 401, 
              template: "error" unless current_user.right_type?('middle_manager')
    end

    def set_self_evaluation
      @self_evaluation =  MiddleManager.find(current_user.id).self_evaluations.activity_year(params[:self_evaluation][:activity_year]).first
    end

    def self_evaluation_params
      params.require(:self_evaluation).permit(
        :duties, :self_evaluation_totality, :activity_year
        )
    end

    def user_info_params
      params.require(:user_info).permit(:job)
    end

end
