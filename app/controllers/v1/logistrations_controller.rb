# frozen_string_literal: true

class V1::LogistrationsController < V1::ApplicationController
  skip_before_action :check_authentication_token,
                     only: :login

  # api :POST, "/login", "Login endpoint for users"
  # formats ["json"]
  # param :email, String,
  #       desc: "User email",
  #       required: true
  # param :password, String,
  #       desc: "User password",
  #       required: true
  def login
    service = Users::Login.new(params)
    service.call

    render_success(UserSerializer.new(service.user, token: service.token))
  end

  # api :DELETE, "/logout",
  #     "Deletes the current authentication token from database"
  # formats ["json"]
  # error 409, "Logout unsuccessful"
  def logout
    @current_auth_token.destroy

    render_success
  end
end
