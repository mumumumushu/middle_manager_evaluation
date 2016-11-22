class Admin::ActivitiesController < ApplicationController
  include ActionView::Layouts
  include ActionController::MimeResponds

  acts_as_token_authentication_handler_for Admin

  before_action :set_activity, only: [:show, :update, :destroy]
  
  respond_to :json

  def index
    page = params[:page] || 1
    per_page = params[:per_page] || 10
    @activities = Activity.all.paginate(page: page, per_page: per_page)
   
    respond_with @activities, template: 'activities/index', status: 200
  end

  def show
    respond_with @activity, template: 'activities/show', status: 200
  end

  def create
    @activity = Activity.new(activity_params)
    if @activity.save
      respond_with @activity, template: 'activities/show', status: 201
    else
      @error = "请确认已上传本次活动的用户名单（上传名单文件名请设置为\"考核年限\"）"
      respond_with @error, template: 'error', status: 200
    end
  end

  def update
    if @activity.update(activity_params)
      respond_with @activity, template: 'activities/show', status: 201
    else
      @error = "请确认已上传本次活动的用户名单（上传名单文件名请设置为\"考核年限\"）"
      respond_with @error, template: 'error', status: 200
    end
  end

  # def destroy
  #   @activity.destroy
  #   respond_with(@activity)
  # end

  private
    def set_activity
      @activity = Activity.find(params[:id])
    end

    def activity_params
      params.require(:activity).permit(
        :activity_year, 
        :first_phase_begin, :first_phase_end, 
        :second_phase_begin, :second_phase_end, 
        :third_phase_begin, :third_phase_end
        )

    end
end
