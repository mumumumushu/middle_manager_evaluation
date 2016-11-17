class Admin::FileOperationController < ApplicationController
  # include ActionView::Layouts
  # include ActionController::MimeResponds

  # acts_as_token_authentication_handler_for Admin

  def load_user_list
  	@error = LoadUserList.load(params[:file].tempfile, File.dirname(__FILE__) + '/../../../')
  	# @error = {error: _error}
  	# respond_with @error, template: 'error'
  end

end