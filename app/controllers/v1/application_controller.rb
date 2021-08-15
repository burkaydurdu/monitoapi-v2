# frozen_string_literal: true
class V1::ApplicationController < ApplicationController
  # Module for HTTP authentication token
  include ActionController::HttpAuthentication::Token::ControllerMethods
  #
  # Authorizations managed with pundit. files are in /app/policies
  include Pundit

  # Rescue Pundit Error (user is not authorized)
  rescue_from Pundit::NotAuthorizedError do
    render_error(AppError::PERMISSION_DENIED)
  end

  # By default Airbrake uses current_user variable for sending the
  # user information with error log. Since we use @current_user, we need to
  # make it usable by Airbrake. Same apply for Pundit.
  attr_reader :current_user

  # Find user, this SHOULD NEVER BE SKIPPED. The endpoints behave differently
  # if a user is logged in or not.
  before_action :find_user_by_token
  #
  # Check authentication token before all requests. This can be skipped for
  # open endpoints
  before_action :check_authentication_token

  # This action will be executed before every request.
  # It checks the authentication token and finds the user.
  def find_user_by_token
    if params[:token].present?
      # token
      @current_auth_token = AuthToken.find_by(token: params[:token])
      @current_user = @current_auth_token&.user
    else
      # token in headers
      authenticate_with_http_token do |token, _options|
        @current_auth_token = AuthToken.find_by(token: token)
        @current_user = @current_auth_token&.user
      end
    end
  end

  # By default, this action is exectued before every requests (can be skipped)
  # renders an error if user not authenticated
  def check_authentication_token
    return unless current_user.nil?

    render_error(AppError::WRONG_AUTHENTICATION_TOKEN)
  end
end
