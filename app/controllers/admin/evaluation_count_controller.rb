class Admin::EvaluationCountController < ApplicationController
  include ActionView::Layouts
  include ActionController::MimeResponds

  acts_as_token_authentication_handler_for Admin
  
  respond_to :json

  def index
    @activity = Activity.where(activity_year: params[:activity_year]).first
    @users = User.where(take_part_in: params[:activity_year]).order(:job_num)
    respond_with @users, template: 'admin/evaluation_count', status: 200
  end

end
