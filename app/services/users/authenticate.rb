# frozen_string_literal: true

class Users::Authenticate < ApplicationService
  def call
    init_user
    authenticate_user
  end

  private

    def init_user
      @user = params[:user]
    end

    def authenticate_user
      raise AppException::MissingParameter if params[:password].blank?

      return if @user.authenticate(params[:password])

      raise AppException::PasswordDontMatch
    end
end
