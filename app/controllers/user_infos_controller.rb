class UserInfosController < ApplicationController
  include ActionView::Layouts
  include ActionController::MimeResponds

  acts_as_token_authentication_handler_for User
  
  before_action :set_user_info, only: [:show]

  respond_to :json

  # def index
  #   @user_infos = UserInfo.all
  #   respond_with(@user_infos)
  # end

  def show
    respond_with(@user_info)
  end

  # def create
  #   @user_info = UserInfo.new(user_info_params)
  #   @user_info.save
  #   respond_with(@user_info)
  # end

  # def update
  #   @user_info.update(user_info_params)
  #   respond_with(@user_info)
  # end

  # def destroy
  #   @user_info.destroy
  #   respond_with(@user_info)
  # end

  private
    def set_user_info
      @user_info = UserInfo.where( :user_id => current_user.id ).first
    end

    # def user_info_params
    #   params[:user_info]
    # end
end
