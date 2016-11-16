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
    @activity.save
    respond_with @activity, template: 'activities/show', status: 201
  end

  def update
    @activity.update(activity_params)
    respond_with @activity, template: 'activities/show', status: 201
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
        :activity_created_year, 
        :first_phase_begin, :first_phase_end, 
        :second_phase_begin, :second_phase_end, 
        :third_phase_begin, :third_phase_end
        )

    end
end
