class ApplicationController < ActionController::Base

  include ResponseUtilities
  include SessionsHelper

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  serialization_scope :view_context

  # before_filter :check_format
  # before_filter :require_auth

  private

  def check_format
    return json_response(406, 'Only JSON requests permitted.') unless params[:format] == 'json'
  end

  def require_auth
  	return json_response(403, 'Not logged in.') unless logged_in?
  end

end
