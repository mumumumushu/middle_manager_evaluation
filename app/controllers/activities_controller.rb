class ActivitiesController < ApplicationController
  include ActionView::Layouts
  include ActionController::MimeResponds

  acts_as_token_authentication_handler_for Admin

  before_action :set_activity, only: [:show, :update, :destroy]
  
  respond_to :json

  def index
    page = params[:page] || 1
    per_page = params[:per_page] || 10
    @activities = Activity.all.paginate(page: page, per_page: per_page)
   
    respond_with(@activities)
  end

  def show
    respond_with(@activity)
  end

  def create
    @activity = activity.new(activity_params)
    @activity.save
    respond_with(@activity)
  end

  # def update
  #   @activity.update(activity_params)
  #   respond_with(@activity)
  # end

  # def destroy
  #   @activity.destroy
  #   respond_with(@activity)
  # end

  private
    def set_activity
      @activity = Activity.find(params[:id])
    end

    def activity_params
      params[:activity]
    end
end
