# frozen_string_literal: true

class V1::UsersController < V1::ApplicationController
  # api :POST, "/register", "Register endpoint for user"
  # formats ["json"]
  # param :email, String,
  #       desc: "User email",
  #       required: true
  # param :name, String,
  #       desc: "User name",
  #       required: false
  # param :surname, String,
  #       desc: "User surname",
  #       required: false
  # param :password, String,
  #       desc: "User password",
  #       required: true
  def register
    user = User.new(user_params)

    return render_success(UserSerializer.new(user)) if user.save

    render_error(AppError::STANDARD_ERROR)
  rescue StandardError
    raise AppException::EmailAlreadyExists
  end

  private

    def user_params
      params.permit(:email, :name, :surname, :password)
    end
end
